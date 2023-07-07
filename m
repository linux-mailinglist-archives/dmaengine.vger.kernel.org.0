Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7B774B77A
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jul 2023 21:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjGGTua (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Jul 2023 15:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjGGTu3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Jul 2023 15:50:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA12A19A5;
        Fri,  7 Jul 2023 12:50:28 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367DkMQi030246;
        Fri, 7 Jul 2023 19:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=JAGetA1FJmjHvB7yI7i7blpX9qiHsKIfcNy1LGGT8hg=;
 b=jaCdu/Ikd38ZoE2xZZ6ag8wM6QzEby/gGywa/TCIoz8tcycfV+o8Gd5JMht4XDUvz85v
 bdV6KCh6rBfta6B8zAHBSSWJkcOOk2uYTOZlNK/gANGyOVLoCrhVzpy4wDxlBl/jg39g
 g93PaK0sHegaEO6uPUD/Ikvuv6pl7gFMPkpkMkB6DyAfyKYA7j2kaBJ7y0HbYNk9e/gF
 74W8ZNDIRNAss+qIUTQQBxYdt1ODXHFqGHTlY6bt2rMTBNdvNhuJ5o3NRPpqGci4Y/xM
 Xvfm5cKO4Exl1h7bVLGvkGy4vzMWCWiRUqRa0nlPDcWNNwsdWEumQmga3lfveE5FM9yq DA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rp96vtbtc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 19:50:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 367JoHKE027545
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Jul 2023 19:50:17 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 7 Jul 2023 12:50:16 -0700
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <okaya@kernel.org>, <vkoul@kernel.org>, <andersson@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH] dmaengine: qcom_hidma: Update codeaurora email domain
Date:   Fri, 7 Jul 2023 13:50:03 -0600
Message-ID: <20230707195003.6619-1-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vngTDZR4zHUxCb1bG0teU5FCY6A35HkA
X-Proofpoint-GUID: vngTDZR4zHUxCb1bG0teU5FCY6A35HkA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_14,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070181
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The codeaurora.org email domain is defunct and will bounce.

Update entries to Sinan's kernel.org address which is the address in
MAINTAINERS for this component.

Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---
 .../ABI/testing/sysfs-platform-hidma          |  2 +-
 .../ABI/testing/sysfs-platform-hidma-mgmt     | 20 +++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-hidma b/Documentation/ABI/testing/sysfs-platform-hidma
index fca40a54df59..a80aeda85ef6 100644
--- a/Documentation/ABI/testing/sysfs-platform-hidma
+++ b/Documentation/ABI/testing/sysfs-platform-hidma
@@ -2,7 +2,7 @@ What:		/sys/devices/platform/hidma-*/chid
 		/sys/devices/platform/QCOM8061:*/chid
 Date:		Dec 2015
 KernelVersion:	4.4
-Contact:	"Sinan Kaya <okaya@codeaurora.org>"
+Contact:	"Sinan Kaya <okaya@kernel.org>"
 Description:
 		Contains the ID of the channel within the HIDMA instance.
 		It is used to associate a given HIDMA channel with the
diff --git a/Documentation/ABI/testing/sysfs-platform-hidma-mgmt b/Documentation/ABI/testing/sysfs-platform-hidma-mgmt
index 3b6c5c9eabdc..0373745b4e18 100644
--- a/Documentation/ABI/testing/sysfs-platform-hidma-mgmt
+++ b/Documentation/ABI/testing/sysfs-platform-hidma-mgmt
@@ -2,7 +2,7 @@ What:		/sys/devices/platform/hidma-mgmt*/chanops/chan*/priority
 		/sys/devices/platform/QCOM8060:*/chanops/chan*/priority
 Date:		Nov 2015
 KernelVersion:	4.4
-Contact:	"Sinan Kaya <okaya@codeaurora.org>"
+Contact:	"Sinan Kaya <okaya@kernel.org>"
 Description:
 		Contains either 0 or 1 and indicates if the DMA channel is a
 		low priority (0) or high priority (1) channel.
@@ -11,7 +11,7 @@ What:		/sys/devices/platform/hidma-mgmt*/chanops/chan*/weight
 		/sys/devices/platform/QCOM8060:*/chanops/chan*/weight
 Date:		Nov 2015
 KernelVersion:	4.4
-Contact:	"Sinan Kaya <okaya@codeaurora.org>"
+Contact:	"Sinan Kaya <okaya@kernel.org>"
 Description:
 		Contains 0..15 and indicates the weight of the channel among
 		equal priority channels during round robin scheduling.
@@ -20,7 +20,7 @@ What:		/sys/devices/platform/hidma-mgmt*/chreset_timeout_cycles
 		/sys/devices/platform/QCOM8060:*/chreset_timeout_cycles
 Date:		Nov 2015
 KernelVersion:	4.4
-Contact:	"Sinan Kaya <okaya@codeaurora.org>"
+Contact:	"Sinan Kaya <okaya@kernel.org>"
 Description:
 		Contains the platform specific cycle value to wait after a
 		reset command is issued. If the value is chosen too short,
@@ -32,7 +32,7 @@ What:		/sys/devices/platform/hidma-mgmt*/dma_channels
 		/sys/devices/platform/QCOM8060:*/dma_channels
 Date:		Nov 2015
 KernelVersion:	4.4
-Contact:	"Sinan Kaya <okaya@codeaurora.org>"
+Contact:	"Sinan Kaya <okaya@kernel.org>"
 Description:
 		Contains the number of dma channels supported by one instance
 		of HIDMA hardware. The value may change from chip to chip.
@@ -41,7 +41,7 @@ What:		/sys/devices/platform/hidma-mgmt*/hw_version_major
 		/sys/devices/platform/QCOM8060:*/hw_version_major
 Date:		Nov 2015
 KernelVersion:	4.4
-Contact:	"Sinan Kaya <okaya@codeaurora.org>"
+Contact:	"Sinan Kaya <okaya@kernel.org>"
 Description:
 		Version number major for the hardware.
 
@@ -49,7 +49,7 @@ What:		/sys/devices/platform/hidma-mgmt*/hw_version_minor
 		/sys/devices/platform/QCOM8060:*/hw_version_minor
 Date:		Nov 2015
 KernelVersion:	4.4
-Contact:	"Sinan Kaya <okaya@codeaurora.org>"
+Contact:	"Sinan Kaya <okaya@kernel.org>"
 Description:
 		Version number minor for the hardware.
 
@@ -57,7 +57,7 @@ What:		/sys/devices/platform/hidma-mgmt*/max_rd_xactions
 		/sys/devices/platform/QCOM8060:*/max_rd_xactions
 Date:		Nov 2015
 KernelVersion:	4.4
-Contact:	"Sinan Kaya <okaya@codeaurora.org>"
+Contact:	"Sinan Kaya <okaya@kernel.org>"
 Description:
 		Contains a value between 0 and 31. Maximum number of
 		read transactions that can be issued back to back.
@@ -69,7 +69,7 @@ What:		/sys/devices/platform/hidma-mgmt*/max_read_request
 		/sys/devices/platform/QCOM8060:*/max_read_request
 Date:		Nov 2015
 KernelVersion:	4.4
-Contact:	"Sinan Kaya <okaya@codeaurora.org>"
+Contact:	"Sinan Kaya <okaya@kernel.org>"
 Description:
 		Size of each read request. The value needs to be a power
 		of two and can be between 128 and 1024.
@@ -78,7 +78,7 @@ What:		/sys/devices/platform/hidma-mgmt*/max_wr_xactions
 		/sys/devices/platform/QCOM8060:*/max_wr_xactions
 Date:		Nov 2015
 KernelVersion:	4.4
-Contact:	"Sinan Kaya <okaya@codeaurora.org>"
+Contact:	"Sinan Kaya <okaya@kernel.org>"
 Description:
 		Contains a value between 0 and 31. Maximum number of
 		write transactions that can be issued back to back.
@@ -91,7 +91,7 @@ What:		/sys/devices/platform/hidma-mgmt*/max_write_request
 		/sys/devices/platform/QCOM8060:*/max_write_request
 Date:		Nov 2015
 KernelVersion:	4.4
-Contact:	"Sinan Kaya <okaya@codeaurora.org>"
+Contact:	"Sinan Kaya <okaya@kernel.org>"
 Description:
 		Size of each write request. The value needs to be a power
 		of two and can be between 128 and 1024.
-- 
2.40.1

