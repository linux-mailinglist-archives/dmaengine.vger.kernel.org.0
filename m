Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966E3251C14
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 17:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgHYPTb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 11:19:31 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:5084 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726813AbgHYPTa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Aug 2020 11:19:30 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07PF8BVl004045;
        Tue, 25 Aug 2020 11:19:15 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3330952011-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 11:19:15 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 07PFJEUA021571
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 25 Aug 2020 11:19:14 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 25 Aug 2020 11:19:13 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 25 Aug 2020 11:19:13 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 25 Aug 2020 11:19:12 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 07PFJ9kv007670;
        Tue, 25 Aug 2020 11:19:09 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <vkoul@kernel.org>, <lars@metafoo.de>, <dan.j.williams@intel.com>,
        <ardeleanalex@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RESEND PATCH v2 0/6] dmaengine: axi-dmac: add support for reading bus attributes from register
Date:   Tue, 25 Aug 2020 18:19:44 +0300
Message-ID: <20200825151950.57605-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-25_05:2020-08-25,2020-08-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 suspectscore=8 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250114
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The series adds support for reading the DMA bus attributes from the
INTERFACE_DESCRIPTION (0x10) register.

The first 5 changes are a bit of rework prior to adding the actual
change in patch 6, as things need to be shifted around a bit, to enable 
the clock to be enabled earlier, to be able to read the version
register.

Changelog v1 -> v2:
* fixed error-exit paths for the clock move patch
  i.e. 'dmaengine: axi-dmac: move clock enable earlier'
* fixed error-exit path for patch
  'axi-dmac: wrap channel parameter adjust into function'
* added patch 'dmaengine: axi-dmac: move active_descs list init after device-tree init'
  the list of active_descs can be moved a bit lower in the init/probe
*** BLURB HERE ***

Alexandru Ardelean (6):
  dmaengine: axi-dmac: move version read in probe
  dmaengine: axi-dmac: move active_descs list init after device-tree
    init
  dmaengine: axi-dmac: move clock enable earlier
  dmaengine: axi-dmac: wrap entire dt parse in a function
  dmaengine: axi-dmac: wrap channel parameter adjust into function
  dmaengine: axi-dmac: add support for reading bus attributes from
    registers

 drivers/dma/dma-axi-dmac.c | 138 ++++++++++++++++++++++++++++---------
 1 file changed, 107 insertions(+), 31 deletions(-)

-- 
2.17.1

