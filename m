Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B324FEB43
	for <lists+dmaengine@lfdr.de>; Sat, 16 Nov 2019 09:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfKPIXd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 16 Nov 2019 03:23:33 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34294 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfKPIXd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 16 Nov 2019 03:23:33 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAG8KKjo006434;
        Sat, 16 Nov 2019 08:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=ySE90lywjVWVk6CxIBLH7KNyGbqL5loGcYsmIkxkJd8=;
 b=OZQpARoE3S+WftyXVFZMdP+6GpglktCasWgOE78VOzckoL+i9ajOJ4RGGA525lQdbXr2
 11CEyXsVR8NhyR8CiXbi/NOIobtmyEuVn9QfhCUkI6tqrLZm7kcz4IJZtFLgGxsp+DGr
 rBpfxH81LHWR2ysT9GUGS72K22M+V7CFiiOWnfN054Db2OMNNcc4KkEu0S3mG6ivUO4C
 sYT+Zf5L8nnk5q/BnWJOdKgQF93SpaLJSE8ONkN9KpfsDh6p08ssBC+F6ekwMxmoLCLL
 bDkIH8PP3k9IOj1Hp0XKH1CEh0bO7l4E7O7T/F1Ti9YGhAErnc/ZimaCjJOhLEfIH6zC yg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2wa9rq0c9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Nov 2019 08:23:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAG8JbXZ060952;
        Sat, 16 Nov 2019 08:23:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2wa687sgdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Nov 2019 08:23:30 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAG8NTCs008356;
        Sat, 16 Nov 2019 08:23:29 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 16 Nov 2019 00:23:28 -0800
Date:   Sat, 16 Nov 2019 11:23:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     green.wan@sifive.com
Cc:     dmaengine@vger.kernel.org
Subject: [bug report] dmaengine: sf-pdma: add platform DMA support for HiFive
 Unleashed A00
Message-ID: <20191116082253.mdowmeywwtroo6xt@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9442 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=711
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911160077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9442 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=781 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911160077
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Green Wan,

This is a semi-automatic email about new static checker warnings.

The patch 6973886ad58e: "dmaengine: sf-pdma: add platform DMA support 
for HiFive Unleashed A00" from Nov 7, 2019, leads to the following 
Smatch complaint:

    drivers/dma/sf-pdma/sf-pdma.c:103 sf_pdma_prep_dma_memcpy()
     error: we previously assumed 'chan' could be null (see line 97)

drivers/dma/sf-pdma/sf-pdma.c
    96	
    97		if (chan && (!len || !dest || !src)) {
                    ^^^^
Check for NULL

    98			dev_err(chan->pdma->dma_dev.dev,
    99				"Please check dma len, dest, src!\n");
   100			return NULL;
   101		}
   102	
   103		desc = sf_pdma_alloc_desc(chan);
                                          ^^^^
Unchecked dereference inside the function.

   104		if (!desc)
   105			return NULL;

regards,
dan carpenter
