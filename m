Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570C263D568
	for <lists+dmaengine@lfdr.de>; Wed, 30 Nov 2022 13:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbiK3MUj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Nov 2022 07:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiK3MUh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Nov 2022 07:20:37 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334F46DCC8;
        Wed, 30 Nov 2022 04:20:36 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AUC7qJo018648;
        Wed, 30 Nov 2022 12:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=6CaDG6FQs1F5uP2IQ8HSQQ6culH2xnBd8bcJ5NL6wnI=;
 b=SfuAYpqUzniYI5MZYvECqfa5kzPy5zykFFoU+/h6vBPxd1Ia/7Fpzs4OQwNxyybOwFUO
 A3yXy9wsLZYx2WoJ+oQzohAOyOa64scLSUTZ8dvZW4JuqneD+jbAkclTaE7J4eH2NnnK
 LADKsnCFDhMP2RviMZ04jzFy+/jYLxd1OkD5WhbU5hqs7Tc07i0bH1Gj03cDChsv5W46
 OyBZRVZ8T3+DqUHjqFNK70crGRVlWRr5D3tzu3kuOl+9Iwx4fMsTb4pwtPh1c+6WhHom
 Tr8rPsPqmQ+x3u0SbMbqze+DmoS69+QjVqUZy+nNDiFXLwfs3BwksyeoSY7Zg/nugazX rw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m66w4g0xn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Nov 2022 12:20:32 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2AUCKSG5031895;
        Wed, 30 Nov 2022 12:20:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3m3bvknc4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 30 Nov 2022 12:20:28 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AUCHAn6028553;
        Wed, 30 Nov 2022 12:20:28 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-vnivarth-hyd.qualcomm.com [10.213.111.166])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 2AUCKRdY031886;
        Wed, 30 Nov 2022 12:20:28 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 1C0D03F58; Wed, 30 Nov 2022 17:50:27 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_vtanuku@quicinc.com,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH] dmaengine: qcom: gpi: Set link_rx bit on GO TRE for rx operation
Date:   Wed, 30 Nov 2022 17:50:24 +0530
Message-Id: <1669810824-32094-1-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: saoNPNDqXdfrcCNlnDl2Qz1j6VK4Ea9y
X-Proofpoint-ORIG-GUID: saoNPNDqXdfrcCNlnDl2Qz1j6VK4Ea9y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-30_04,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=848 mlxscore=0 spamscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211300087
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

As per GSI spec, link_rx bit is to be set on GO TRE on tx
channel whenever there is going to be a DMA TRE on rx
channel. This is currently set for duplex operation only.

Set the bit for rx operation as well.

Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
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

