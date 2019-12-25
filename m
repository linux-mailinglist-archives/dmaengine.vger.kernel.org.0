Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54B5012A8B6
	for <lists+dmaengine@lfdr.de>; Wed, 25 Dec 2019 18:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfLYRvw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Dec 2019 12:51:52 -0500
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:10942 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbfLYRvw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Dec 2019 12:51:52 -0500
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBPHoJLt012046
        for <dmaengine@vger.kernel.org>; Wed, 25 Dec 2019 12:51:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=X4yF8u+5wNugZMocgh7rxAl5MPWDbBMx2rgNxGq4wR0=;
 b=WcBm/z37a5QGAhJ672fdSDGS6pa5L981AFyIcaGidgMjbcLtXYaupfifblk1u/DaRI22
 X0bsiRf20kmIdHD4aOjZxNCS7But6hgIBYhuk0KS2mgtEWdAd3685wlkxYzWCy5mVEB2
 1J6SU7GmwcuCLYRvV6Fd0e91sLrZtI8Do3sRCDJDRCFvCNgDPY0LYwFb8m0UZL/y8v7J
 d1tycZL8ewVTfih0KkNnDwsF0rYbVgD+Wfnc48zCaStnXgFrjeo8PYsRazwvsGNOV0pY
 2HZ+m8pLsWe/WtXSyaz23Ky07s4HFJzS9VHPIQUCT68xuSLD0tFkyZleKINRssnm/M+6 lA== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 2x1eu9g1ag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <dmaengine@vger.kernel.org>; Wed, 25 Dec 2019 12:51:50 -0500
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBPHlOUB047843
        for <dmaengine@vger.kernel.org>; Wed, 25 Dec 2019 12:51:50 -0500
Received: from ausc60pc101.us.dell.com (ausc60pc101.us.dell.com [143.166.85.206])
        by mx0b-00154901.pphosted.com with ESMTP id 2x3h6sy2p2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <dmaengine@vger.kernel.org>; Wed, 25 Dec 2019 12:51:50 -0500
X-LoopCount0: from 10.166.137.65
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1509058808"
From:   <Alexander.Barabash@dell.com>
To:     <dmaengine@vger.kernel.org>
CC:     <alexander.barabash@gmail.com>
Subject: [PATCH] ioat: ioat_alloc_ring() failure handling.
Thread-Topic: [PATCH] ioat: ioat_alloc_ring() failure handling.
Thread-Index: AdW7S7t3OEtrn+MQRUGa96xmXOj06w==
Date:   Wed, 25 Dec 2019 17:51:48 +0000
Message-ID: <97d0e388cbf64efe9fad8c340713e4d8@x13pwhopdag1307.AMER.DELL.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Alexander.Barabash@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-12-25T17:50:06.9044505Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.146.130.80]
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-25_05:2019-12-24,2019-12-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=453 impostorscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912250153
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=585 clxscore=1015
 lowpriorityscore=0 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912250153
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If dma_alloc_coherent() returns NULL in ioat_alloc_ring(), ring
allocation must not proceed.

Until now, if the first call to dma_alloc_coherent() in
ioat_alloc_ring() returned NULL, the processing could proceed, failing
with NULL-pointer dereferencing further down the line.

Signed-off-by: Alexander Barabash <alexander.barabash@dell.com>
---
 drivers/dma/ioat/dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index 1a422a8..e1553ae 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -377,7 +377,7 @@ struct ioat_ring_ent **
=20
 		descs->virt =3D dma_alloc_coherent(to_dev(ioat_chan),
 						 SZ_2M, &descs->hw, flags);
-		if (!descs->virt && (i > 0)) {
+		if (!descs->virt) {
 			int idx;
=20
 			for (idx =3D 0; idx < i; idx++) {
--=20
1.8.3.1
