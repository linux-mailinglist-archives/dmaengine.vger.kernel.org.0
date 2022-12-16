Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03F264F075
	for <lists+dmaengine@lfdr.de>; Fri, 16 Dec 2022 18:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiLPRih (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Dec 2022 12:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbiLPRie (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Dec 2022 12:38:34 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6774046A;
        Fri, 16 Dec 2022 09:38:32 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGGl4HJ024811;
        Fri, 16 Dec 2022 17:38:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=zvx71KrV2LmSl2ZPn2MfklBoJ/9bDIChVxCtNYbUrgI=;
 b=KkpP0oekqWOEc+TBWGUO/5T4Ym4M0MwWdMEFaVLduCvatQkJwNumuKJvrlL5MCiQYI4i
 UDnSroZ17iDLYzC6MkEZpVNXYUoPZ2gkFBWM1//yCg2wCqMCYj51tU17cdGYPzUxKw/4
 utqa3pYWsdGifj+BLhEiyXOAp/r7tK/W1UqOKmAyRd7VZHmwXKYSgeMAUWQZMKqYgiOa
 8GiBHQP/przSfnRsZZfaPVFiGt7ASc3+y0SSoVt369F1Lz97QkLCAmFm30VOWkVaY1n7
 3KtEwP/glU0XukHFcFlmTtpKheW/Mq6l2FDvJ9HAK5c+Y3GfbqYCkF1sgKNbnthx1rOz 6w== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mgmv11hb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 17:38:23 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2BGHcJb6016047;
        Fri, 16 Dec 2022 17:38:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3mck6kxv5n-1;
        Fri, 16 Dec 2022 17:38:19 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BGHcJGC016039;
        Fri, 16 Dec 2022 17:38:19 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-vnivarth-hyd.qualcomm.com [10.213.111.166])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 2BGHcIcv016038;
        Fri, 16 Dec 2022 17:38:19 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 13E233D72; Fri, 16 Dec 2022 23:08:18 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_vtanuku@quicinc.com,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [V2] dmaengine: qcom: gpi: Set link_rx bit on GO TRE for rx operation
Date:   Fri, 16 Dec 2022 23:08:13 +0530
Message-Id: <1671212293-14767-1-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -LpND4nb_KBVeun0hVtawLFVdBSBJOK_
X-Proofpoint-ORIG-GUID: -LpND4nb_KBVeun0hVtawLFVdBSBJOK_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_12,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=816 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212160152
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Rx operation on SPI GSI DMA is currently not working.
As per GSI spec, link_rx bit is to be set on GO TRE on tx
channel whenever there is going to be a DMA TRE on rx
channel. This is currently set for duplex operation only.

Set the bit for rx operation as well.
This is part of changes required to bring up Rx.

Fixes: 94b8f0e58fa1 ("dmaengine: qcom: gpi: set chain and link flag for duplex")
Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
---
v1 -> v2:
- updated change description
---
 drivers/dma/qcom/gpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 061add8..59a36cb 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -1756,6 +1756,7 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
 		tre->dword[3] = u32_encode_bits(TRE_TYPE_GO, TRE_FLAGS_TYPE);
 		if (spi->cmd == SPI_RX) {
 			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOB);
+			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_LINK);
 		} else if (spi->cmd == SPI_TX) {
 			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_CHAIN);
 		} else { /* SPI_DUPLEX */
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

