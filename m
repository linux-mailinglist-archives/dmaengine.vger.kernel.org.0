Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 128C350C61
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2019 15:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbfFXNuT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Jun 2019 09:50:19 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33108 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731346AbfFXNuS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 24 Jun 2019 09:50:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5ODnJLY183689;
        Mon, 24 Jun 2019 13:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=VzFjbN80m/KS7QJTT9HnF1kNBWl2jZh8kiE34VZK/n4=;
 b=g7iSod1xfT4Y1f3EQiqikJ5APoIwdZgrvbUIeZ/WUPAvUGkrX0RGSPoV0jr0hO6fT+H3
 jM+r361lrlCwyjvbLGtgFb2cHZQh5BBp/HX3TXvRKfVln+7FkFkLUGDiQ0aO6LFPfRvm
 S9zz7lAy2JwnUmOeJ2z6uAV7qZ1jO3smkNmY8q+RH+hoU48x4vRJHWgpT6PiI4rVo5ny
 goae6/kfhNjpIxxRIqCQVX5fi3BCA3pLEuW0eYxlR44hI/0xpHtAA1Ep+HNY/2yIhll3
 236nQFfWIrzJj/Rr2d6IvOWOvLQaEwgn4+/pwPNTZ2Y7OWzE4AkM3VKG+m604biE25mk /Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t9brsxjd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 13:49:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5ODnMWU113398;
        Mon, 24 Jun 2019 13:49:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2tat7bn74c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 13:49:51 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5ODnltl013483;
        Mon, 24 Jun 2019 13:49:48 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 06:49:47 -0700
Date:   Mon, 24 Jun 2019 16:49:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] dmaengine: jz4780: Fix an endian bug in IRQ handler
Message-ID: <20190624134940.GC1754@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=923
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=974 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240113
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The "pending" variable was a u32 but we cast it to an unsigned long
pointer when we do the for_each_set_bit() loop.  The problem is that on
big endian 64bit systems that results in an out of bounds read.

Fixes: 4e4106f5e942 ("dmaengine: jz4780: Fix transfers being ACKed too soon")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I don't know if this driver is ever used on a big endian 64 bit system,
but the fix is pretty easy and it silences a static checker warning.

Not tested.

 drivers/dma/dma-jz4780.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 77260a6f5178..dfd10fe3c9b3 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -717,12 +717,13 @@ static irqreturn_t jz4780_dma_irq_handler(int irq, void *data)
 {
 	struct jz4780_dma_dev *jzdma = data;
 	unsigned int nb_channels = jzdma->soc_data->nb_channels;
-	uint32_t pending, dmac;
+	unsigned long pending;
+	uint32_t dmac;
 	int i;
 
 	pending = jz4780_dma_ctrl_readl(jzdma, JZ_DMA_REG_DIRQP);
 
-	for_each_set_bit(i, (unsigned long *)&pending, nb_channels) {
+	for_each_set_bit(i, &pending, nb_channels) {
 		if (jz4780_dma_chan_irq(jzdma, &jzdma->chan[i]))
 			pending &= ~BIT(i);
 	}
-- 
2.20.1

