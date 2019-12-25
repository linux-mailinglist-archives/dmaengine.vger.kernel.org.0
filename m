Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D060B12A8B7
	for <lists+dmaengine@lfdr.de>; Wed, 25 Dec 2019 18:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfLYRzf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Dec 2019 12:55:35 -0500
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:29248 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbfLYRzf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Dec 2019 12:55:35 -0500
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBPHoIXp028046
        for <dmaengine@vger.kernel.org>; Wed, 25 Dec 2019 12:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=rKD0Y3xVcvN7O8cIarRRJ9zxdFdpfi0M1q4QCkcYtIk=;
 b=ZWBhxdO3Qquw3T2Fdnda6qZhyzzpiEkO0YkBB6IoUeqM/wJdADV+GBkwQ5q4ys4b1JDr
 CF4Zd9iCu5cYryLdk2pv7UXkAQ50p6Wwsw6pNjBPYxsWC7QS8E5WMjPuhoQwlWKTDUWy
 w8aKVzNZpDtdCvYLedaaziEPDdjDnnoZkPzd3agq/JYEgF4dLq040K3Xu45oQYcrbrEY
 wsB7dWNUPHz+bvJeumM9Vw/fDt/Xiha3DqbRz9lyj1J1adz54X+97EO9tChDmWqcKyDl
 dOvy7SD5m+CAHwxSE5x585WDnceC9u8sU0hoTmzIJQmoCZaeeH/UZjRNjUYpgH9FHj6E 6Q== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2x1g9pfthn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <dmaengine@vger.kernel.org>; Wed, 25 Dec 2019 12:55:33 -0500
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBPHlWLC055576
        for <dmaengine@vger.kernel.org>; Wed, 25 Dec 2019 12:55:32 -0500
Received: from ausc60ps301.us.dell.com (ausc60ps301.us.dell.com [143.166.148.206])
        by mx0b-00154901.pphosted.com with ESMTP id 2x3ff287b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <dmaengine@vger.kernel.org>; Wed, 25 Dec 2019 12:55:32 -0500
X-LoopCount0: from 10.166.132.129
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1392780705"
From:   <Alexander.Barabash@dell.com>
To:     <dmaengine@vger.kernel.org>
CC:     <alexander.barabash@gmail.com>
Subject: [PATCH v2] ioat: ioat_alloc_ring() failure handling.
Thread-Topic: [PATCH v2] ioat: ioat_alloc_ring() failure handling.
Thread-Index: AdW7TGc/gGAW5DKzQbaZyKysabWdZg==
Date:   Wed, 25 Dec 2019 17:55:30 +0000
Message-ID: <75e9c0e84c3345d693c606c64f8b9ab5@x13pwhopdag1307.AMER.DELL.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Alexander.Barabash@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-12-25T17:55:28.3439867Z;
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=399
 mlxscore=0 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912250153
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 adultscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 mlxlogscore=531
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
 drivers/dma/ioat/dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index 1a422a8..18c011e 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -377,10 +377,11 @@ struct ioat_ring_ent **
=20
 		descs->virt =3D dma_alloc_coherent(to_dev(ioat_chan),
 						 SZ_2M, &descs->hw, flags);
-		if (!descs->virt && (i > 0)) {
+		if (!descs->virt) {
 			int idx;
=20
 			for (idx =3D 0; idx < i; idx++) {
+				descs =3D &ioat_chan->descs[idx];
 				dma_free_coherent(to_dev(ioat_chan), SZ_2M,
 						  descs->virt, descs->hw);
 				descs->virt =3D NULL;
--=20
1.8.3.1

