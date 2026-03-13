Return-Path: <dmaengine+bounces-9423-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Fq+N/+zs2lYZwAAu9opvQ
	(envelope-from <dmaengine+bounces-9423-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 13 Mar 2026 07:51:43 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF8427E5B4
	for <lists+dmaengine@lfdr.de>; Fri, 13 Mar 2026 07:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C6D2306ECA0
	for <lists+dmaengine@lfdr.de>; Fri, 13 Mar 2026 06:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDA834F24B;
	Fri, 13 Mar 2026 06:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oj8NB/Fb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kGpOOiK2"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C8B3537F7
	for <dmaengine@vger.kernel.org>; Fri, 13 Mar 2026 06:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773384588; cv=none; b=TbIAGpRuWVtg5kxsOmtQqp+8Pcy+C3FGP/u0Bazy9lFfR8hzcO+tE8w7+RiVOibCbCfUPQ/xsXqzKVvdrEHfx6TQV71CqAAug9C5+mYhqY9EXKIg2WyHk1JgUjZ6XRwfZvIQakq/yjvdVPgoMImCEZ6zSOfAT/TEAMUs18u1HZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773384588; c=relaxed/simple;
	bh=k6vgIbvxkBkgZrvr1Ay0S0k9wxYlh+Jlh1SzYi04ePs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n88ZCIgUFMe0ww0mhoIuUm+Aso7T+olHKBKQyFaPBnobpsBlO0ZiF296CZohYdLM7+cjdA6gUZ1ZAeSF9jH4qn/qD2Iu+Ge/1fJLWq/9LnGXoa6UaYuiWORAKKmsUVS2B/V8HV7/l3J5KTIAJDLnu7e6VqZQEGb3YqHtzQ8Hr1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oj8NB/Fb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kGpOOiK2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5tjTg1015006
	for <dmaengine@vger.kernel.org>; Fri, 13 Mar 2026 06:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WI/YHY7kRAO8WhJyXthZ+dRzS9S21OyP3MUfXR4/TeQ=; b=oj8NB/FbvBsFQAJK
	WrTZiBScbi/PtOJXIJN6NL7pOjQ3NrMQ3128lPFNyzMLRZeL4dxAzeYUU2Z4y1rc
	en+qIkshpM3Y8BieldEnmmiJGlag2vuQMOslxt94rdXcA25xpEtppHVVQEtPr4AV
	iYMXaVq8ALBW19Fu9UDHunuHLiXL6qkK4S4kp1F8x5Rv4Uy7zq7OfeAJdSWDSr08
	xa9ZKjzucB6qU/HxxghQ66esArUIl/WqWUrmm75eXxjJlM79ax8r8DPl+1ZY0FmA
	4x/22qYQlrK9JaGJO/4yjVicKldToXR9HqD+EKwnt0qlHiAepNkVMISwFvpYwURo
	dC8CSw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cumvdm7kv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 13 Mar 2026 06:49:45 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ae4b96c259so30288895ad.1
        for <dmaengine@vger.kernel.org>; Thu, 12 Mar 2026 23:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773384585; x=1773989385; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WI/YHY7kRAO8WhJyXthZ+dRzS9S21OyP3MUfXR4/TeQ=;
        b=kGpOOiK2C8kUpqZyC2g6x+rtR/1z8DqexlqVlNoxt404vko2J/Ebq3xEWPlvJrHpPK
         6OeWJ98OWL3Xfai2/5qp4DftxoKmy65AYWeu1HPCfuYAJWEG0OzLr4dEyV1DmZYY2ww6
         mBrfC5S6pmL6G/RokisNlr/nMGzA5iTO9iY+IxGoTxv7GxBUoML8CQ6OXELa04RYGcTx
         wCd8w2VD1dU8/fqwwJNEq6jGcnbxDxAoHDbbG2vbE890xiTdTFEad2TBV7iG9a3+7V8X
         TL+F0uCLwSuysLtNOe7v3K+mX9XNtIqGd9sdEyY8Yg+38tFborAVG1OBaRKyU35ZW3Zl
         Lp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773384585; x=1773989385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WI/YHY7kRAO8WhJyXthZ+dRzS9S21OyP3MUfXR4/TeQ=;
        b=SCkJw4uDJt5g4GJbLXnpr8fE2IU23y8SwcrsNffPI6qFF1NpIRzxD1NIEbb7n1E5Nx
         A1cuWbInFOUZkmhwqgGabz7O9oPXdnewSTP25F081lbEqczGBlkMXrc6YWHoTV+4EpTP
         7FqLiK4wDgYTiYLJAIOyewlGR1ViMQqdFn7yZK2ot8IoQitWoUYX9Zr9JxBePVitJfGD
         e5d1SRJi4hPSNwMy30JMTWwbS9wNDHlLpfSqimQvHDMLtA43lGjBbblZYrJHtA43usli
         ACGd3J3mUlFTcvwUYR3cCrhWziy9vdcG0ZMTWwwBVpmD+i3zidle23His1Te7EM2Ifk0
         zkvQ==
X-Gm-Message-State: AOJu0YwRkaRBV2qV7FUEvBPNDjoAd0lWIOlPJ9I3V4uA04lk0JOdoiYS
	I1dH2hjQfOhXSiZdXYsKB/t6J7CWrTz71ZysARt9iRTtHYCg++aBlphmoucHlwM5Jj9z3/SHfw3
	5FL2zcQH5+4VNLxnQ7QPqUyGNbawmhN+8UK6HLz6bxzakPSTVyK2pAzSp11sR8BI=
X-Gm-Gg: ATEYQzxJLUUvYskKrlZRJ3cfPNpr1xFFgW7qMVnBLkdZQ+ZP5mIF69UTb/SvkjyyoPa
	5159PM5dCQrzGSJIRgD0hCcahtLYFKhpc4Fmn7onbd6EpuIizHW0JWoEpdtkheivC78iQSGivJX
	YCZfqYe75PZosQEl37qWGf+d3PJGgwWkR1InElWU4NbWG7MDA1h3ZUG5IGWnUq9P/bhhyBGyZOe
	2u27Kp/yy06mwHneC9AfKLYBoX7r9FNY4wNJuG9lQ5UhiZAhATeVEEgGjOaS4E7HocN6sqCntVj
	lz4RuB01sxyWBWrt5YeYBm//3Zt937Oosmirkuh1GfAFMTlqyDmj7DOjYVSsTuL1hHMs23YUTbY
	WbkxCzp0KfKORBS8sXP0ZoUVJggnXn/oBsXcq2s27LwvweTE=
X-Received: by 2002:a05:6a20:2d09:b0:398:87a9:fe2 with SMTP id adf61e73a8af0-398eb1d70c5mr1849852637.25.1773384584653;
        Thu, 12 Mar 2026 23:49:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:2d09:b0:398:87a9:fe2 with SMTP id adf61e73a8af0-398eb1d70c5mr1849833637.25.1773384584078;
        Thu, 12 Mar 2026 23:49:44 -0700 (PDT)
Received: from hu-sumk-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73eb97b41dsm936160a12.5.2026.03.12.23.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 23:49:43 -0700 (PDT)
From: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 12:19:26 +0530
Subject: [PATCH 2/3] PCI: epf-mhi: Add batched DMA read support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-dma_multi_sg-v1-2-8fabb0d1a759@oss.qualcomm.com>
References: <20260313-dma_multi_sg-v1-0-8fabb0d1a759@oss.qualcomm.com>
In-Reply-To: <20260313-dma_multi_sg-v1-0-8fabb0d1a759@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Veerabhadrarao Badiganti <veerabhadrarao.badiganti@oss.qualcomm.com>,
        Subramanian Ananthanarayanan <subramanian.ananthanarayanan@oss.qualcomm.com>,
        Akhil Vinod <akhil.vinod@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-pci@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Sumit Kumar <sumit.kumar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773384567; l=7035;
 i=sumit.kumar@oss.qualcomm.com; s=20250409; h=from:subject:message-id;
 bh=k6vgIbvxkBkgZrvr1Ay0S0k9wxYlh+Jlh1SzYi04ePs=;
 b=9rakX7K74VAxnZ8NzPQjT3GERB9y7D6V/TUxZjoPmC7LqQa4Xyy75MoogT6Fx1BxFU9D4VO8S
 vnbN0h/NtmVA57SHjyMKEhLXOF3H8g9j/z6/D068L/SCJuJVhIFwUn9
X-Developer-Key: i=sumit.kumar@oss.qualcomm.com; a=ed25519;
 pk=3cys6srXqLACgA68n7n7KjDeM9JiMK1w6VxzMxr0dnM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA1MyBTYWx0ZWRfX3xvPpMTnVYnX
 8/SVzFW/OH13R0IU+ZxvVhZFjPW30fuuKIK0TBhD5xhe1zoVb3BLJrvxLDrWeHPQ2/HVp02Xf2/
 qvooOr+oST9MnTkIhUmwjmRfSvjOb8JNtnYkPt9Eq9E90B5s6FAgW7xYk8Ao7g3LIQyBFjyBQKm
 twLqtkyObxTNtVsNJKZbIIPVoE/mR6RTpNvQpxKcPxQ3e964LNOQ/klkOaz6uvck6pay/kFbkMW
 QW8VPWXFrySOkXQoAKspGxhFmcd2ZJ4o6mBte+WSZIl6THSefIqWpcGYzJHhI/rJqIgh8IT0lza
 Sk7pIMkdyYmXkLgQhZBgKXD4ii7bALYaGKsxZzu4XFbZZr8qfjLXpewArFKZO62h6Bpsz87oU5a
 clfWtLI2v5Ke4B9otbU5p6QNRg/a+XwFAIJtn1xE+6AsI+U8lLSQWkv80wOC5Ik8JsacX4gyhuf
 Tdmot72gJ2s6HxL2C8Q==
X-Proofpoint-GUID: cNal9tJfrbz3Uf3K7SFDOJSX775e_JeC
X-Proofpoint-ORIG-GUID: cNal9tJfrbz3Uf3K7SFDOJSX775e_JeC
X-Authority-Analysis: v=2.4 cv=XsT3+FF9 c=1 sm=1 tr=0 ts=69b3b389 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=bHNg01yGDDtxrYhjzSoA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130053
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-9423-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.kumar@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8EF8427E5B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for batched DMA transfers in the PCI EPF MHI driver to
improve performance when reading multiple buffers from the host.

Implement two variants of the read_batch() callback:
- pci_epf_mhi_edma_read_batch(): DMA-optimized implementation using
  dmaengine_prep_batch_sg_dma() to transfer multiple buffers in a single
  DMA transaction.
- pci_epf_mhi_iatu_read_batch(): CPU-copy fallback that sequentially
  processes buffers using IATU.

This enables the MHI endpoint stack to efficiently cache ring data,
particularly for wraparound scenarios where ring data spans two
non-contiguous memory regions.

Signed-off-by: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
---
 drivers/pci/endpoint/functions/Kconfig       |   1 +
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 120 +++++++++++++++++++++++++++
 include/linux/mhi_ep.h                       |   3 +
 3 files changed, 124 insertions(+)

diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
index 0c9cea0698d7bd3d8bd11aa1db0195978d9406b9..43131b6db8a2ca57b7a4f0eba8affba3a77f9ad7 100644
--- a/drivers/pci/endpoint/functions/Kconfig
+++ b/drivers/pci/endpoint/functions/Kconfig
@@ -41,6 +41,7 @@ config PCI_EPF_VNTB
 config PCI_EPF_MHI
 	tristate "PCI Endpoint driver for MHI bus"
 	depends on PCI_ENDPOINT && MHI_BUS_EP
+	select NEED_SG_DMA_DST_ADDR
 	help
 	   Enable this configuration option to enable the PCI Endpoint
 	   driver for Modem Host Interface (MHI) bus in Qualcomm Endpoint
diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 6643a88c7a0ce38161bc6253c09d29f1c36ba394..198201d734cc2c6d09be229464a8efdafc3cd611 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -448,6 +448,124 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
 	return ret;
 }
 
+static int pci_epf_mhi_iatu_read_batch(struct mhi_ep_cntrl *mhi_cntrl,
+				       struct mhi_ep_buf_info *buf_info_array,
+				       u32 num_buffers)
+{
+	int ret;
+	u32 i;
+
+	for (i = 0; i < num_buffers; i++) {
+		ret = pci_epf_mhi_iatu_read(mhi_cntrl, &buf_info_array[i]);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int pci_epf_mhi_edma_read_batch(struct mhi_ep_cntrl *mhi_cntrl,
+				       struct mhi_ep_buf_info *buf_info_array,
+				       u32 num_buffers)
+{
+	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
+	struct device *dma_dev = epf_mhi->epf->epc->dev.parent;
+	struct dma_chan *chan = epf_mhi->dma_chan_rx;
+	struct device *dev = &epf_mhi->epf->dev;
+	struct dma_async_tx_descriptor *desc;
+	struct dma_slave_config config = {};
+	DECLARE_COMPLETION_ONSTACK(complete);
+	struct scatterlist *sg;
+	dma_addr_t *dst_addrs;
+	dma_cookie_t cookie;
+	int ret;
+	u32 i;
+
+	if (num_buffers == 0)
+		return -EINVAL;
+
+	mutex_lock(&epf_mhi->lock);
+
+	sg = kcalloc(num_buffers, sizeof(*sg), GFP_KERNEL);
+	if (!sg) {
+		ret = -ENOMEM;
+		goto err_unlock;
+	}
+
+	dst_addrs = kcalloc(num_buffers, sizeof(*dst_addrs), GFP_KERNEL);
+	if (!dst_addrs) {
+		ret = -ENOMEM;
+		goto err_free_sg;
+	}
+
+	sg_init_table(sg, num_buffers);
+
+	for (i = 0; i < num_buffers; i++) {
+		dst_addrs[i] = dma_map_single(dma_dev, buf_info_array[i].dev_addr,
+					      buf_info_array[i].size, DMA_FROM_DEVICE);
+		ret = dma_mapping_error(dma_dev, dst_addrs[i]);
+		if (ret) {
+			dev_err(dev, "Failed to map buffer %u\n", i);
+			goto err_unmap;
+		}
+
+		sg_dma_address(&sg[i]) = buf_info_array[i].host_addr;
+		sg_dma_dst_address(&sg[i]) = dst_addrs[i];
+		sg_dma_len(&sg[i]) = buf_info_array[i].size;
+	}
+
+	config.direction = DMA_DEV_TO_MEM;
+	ret = dmaengine_slave_config(chan, &config);
+	if (ret) {
+		dev_err(dev, "Failed to configure DMA channel\n");
+		goto err_unmap;
+	}
+
+	desc = dmaengine_prep_batch_sg_dma(chan, sg, num_buffers,
+					   DMA_DEV_TO_MEM,
+					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	if (!desc) {
+		dev_err(dev, "Failed to prepare batch sg DMA\n");
+		ret = -EIO;
+		goto err_unmap;
+	}
+
+	desc->callback = pci_epf_mhi_dma_callback;
+	desc->callback_param = &complete;
+
+	cookie = dmaengine_submit(desc);
+	ret = dma_submit_error(cookie);
+	if (ret) {
+		dev_err(dev, "Failed to submit DMA\n");
+		goto err_unmap;
+	}
+
+	dma_async_issue_pending(chan);
+
+	ret = wait_for_completion_timeout(&complete, msecs_to_jiffies(1000));
+	if (!ret) {
+		dev_err(dev, "DMA transfer timeout\n");
+		dmaengine_terminate_sync(chan);
+		ret = -ETIMEDOUT;
+		goto err_unmap;
+	}
+
+	ret = 0;
+
+err_unmap:
+	for (i = 0; i < num_buffers; i++) {
+		if (dst_addrs[i])
+			dma_unmap_single(dma_dev, dst_addrs[i],
+					 buf_info_array[i].size, DMA_FROM_DEVICE);
+	}
+	kfree(dst_addrs);
+err_free_sg:
+	kfree(sg);
+err_unlock:
+	mutex_unlock(&epf_mhi->lock);
+	return ret;
+}
+
 static void pci_epf_mhi_dma_worker(struct work_struct *work)
 {
 	struct pci_epf_mhi *epf_mhi = container_of(work, struct pci_epf_mhi, dma_work);
@@ -803,11 +921,13 @@ static int pci_epf_mhi_link_up(struct pci_epf *epf)
 	mhi_cntrl->unmap_free = pci_epf_mhi_unmap_free;
 	mhi_cntrl->read_sync = mhi_cntrl->read_async = pci_epf_mhi_iatu_read;
 	mhi_cntrl->write_sync = mhi_cntrl->write_async = pci_epf_mhi_iatu_write;
+	mhi_cntrl->read_batch = pci_epf_mhi_iatu_read_batch;
 	if (info->flags & MHI_EPF_USE_DMA) {
 		mhi_cntrl->read_sync = pci_epf_mhi_edma_read;
 		mhi_cntrl->write_sync = pci_epf_mhi_edma_write;
 		mhi_cntrl->read_async = pci_epf_mhi_edma_read_async;
 		mhi_cntrl->write_async = pci_epf_mhi_edma_write_async;
+		mhi_cntrl->read_batch = pci_epf_mhi_edma_read_batch;
 	}
 
 	/* Register the MHI EP controller */
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index 7b40fc8cbe77ab8419d167e89264b69a817b9fb1..15554f966e4be1aea1f3129c5f26253f5087edba 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -107,6 +107,7 @@ struct mhi_ep_buf_info {
  * @write_sync: CB function for writing to host memory synchronously
  * @read_async: CB function for reading from host memory asynchronously
  * @write_async: CB function for writing to host memory asynchronously
+ * @read_batch: CB function for reading from host memory in batches synchronously
  * @mhi_state: MHI Endpoint state
  * @max_chan: Maximum channels supported by the endpoint controller
  * @mru: MRU (Maximum Receive Unit) value of the endpoint controller
@@ -164,6 +165,8 @@ struct mhi_ep_cntrl {
 	int (*write_sync)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_info *buf_info);
 	int (*read_async)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_info *buf_info);
 	int (*write_async)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_info *buf_info);
+	int (*read_batch)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_info *buf_info_array,
+			  u32 num_buffers);
 
 	enum mhi_state mhi_state;
 

-- 
2.34.1


