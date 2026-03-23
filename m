Return-Path: <dmaengine+bounces-9600-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMa0EYZxwWkQTQQAu9opvQ
	(envelope-from <dmaengine+bounces-9600-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 17:59:50 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D73A42F941E
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 17:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E0CC34CDE67
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 15:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091F0283FE5;
	Mon, 23 Mar 2026 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZMwFn+ga";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i8g+RUOJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D4325A35A
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279052; cv=none; b=ZWxFdQZxI+SraCDyNHAI1E6p20rrb62zT2cI486TQ39Z4iabxQw7+aKWQ+iXFsiT7IhNJ8xMXpI5dqeGrsjenbp3mCIBsOCGy1uhOkIIzXKabVdQAeQwNC0zzLSLOXgafOOVE9QsaOplVEfBgYqGV4SwFXj82/x2ci+5btStGS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279052; c=relaxed/simple;
	bh=V/kExSnp4gLekFUspVMuJp40Wa32cu/zESSu6vck61c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rGsmmgfDH6f3QhX5ziUxy2tbS18YhCe1kBW6N+ki9TkGIRsL4EvETYc/R4Cd+3EaMnB/Vz+wIlkZvUKX99aO3EpMwAEVXbcXzL4eBCKOtWbRQuzGrAB8hgGTiJOAZm/epp5WACyvtCdI/vX8VIEMBL4E4urzfmN+1bRe92gN8xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZMwFn+ga; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i8g+RUOJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NFGThI599488
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OOwdxQEYbJ9Or9A0mYUFJoOOp6SzbaWszXsvmPmeoCo=; b=ZMwFn+garoGd9oYR
	VgRetVPwKMUkR8NR6dfmbBuLWV7upO672tDDSQdo2b/KxeYt68QyNhnVgVIOvWmo
	gp8bBaRcEnP1Rxu2Ftd86Sa/ynfF6t7lEAlQ9IUKLPB+VPz2SnMa9kbkCKRR7r6G
	wi0yvX8pml6ehf9kV38CVrjQt0aB/71Ux/TZEDDr+koT1Xgxv2tZA+m4lT7XlYcF
	UQUZ+hC49gt4yeQfvOtXmSMzGhHbfCbwGpoEvVxE6JfTUy60Vn/ZwMXNO4zQ49qM
	s0EWxlh2uOaMN+dGAE4voHDytpPDEgzuW6v8YeWduQ1rganE6mu/kBHntFuFv6BG
	eO9DDg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d34vkrs6c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:17:30 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-951649dae81so1030859241.1
        for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 08:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774279050; x=1774883850; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OOwdxQEYbJ9Or9A0mYUFJoOOp6SzbaWszXsvmPmeoCo=;
        b=i8g+RUOJrBD3IzF4ozycX2oDv3SsrB1lPZgO5oyCq/T64wbsW8nt4qPv5bq+Y80WH+
         F1xC1fcPQCoXxt6HY77CFUNmXiv9B9sv7JPOwhLzfBzp4f6ljP5F0H5hv1d75eF0YyCm
         di3uXBwStCEvjG7NtB0z9LKRbC59gHPRBte63xIItJND0JyKQfKDuLFr3LXb8hLOaqhr
         HfamjlWlQpP2U4nsuJF4i6pZBlK7QDPx/kefoj20NOyJ/fAEGLYKQgHl94nVfJRIwn1M
         JH5QKcwf7MKqXnuhCycV6hBEqFTYX+3W5nayOd+d2SmBKW8gHZoSfJ6hQDp+z8OshU/T
         P1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774279050; x=1774883850;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OOwdxQEYbJ9Or9A0mYUFJoOOp6SzbaWszXsvmPmeoCo=;
        b=VhpUMl28pa3nOy9br2SbIZ4HG/oKHyoTgkO1uVaWrMldVnEbnu7HiLu01ybrLhKP5r
         jioPXwcTpoXFWpBTdlHlH4OMcQoTAuCA9q4DdNvE8GBNKHAjQbG180E/QEzlR4f7iYiD
         gHWOsdCaaucOE6x6xMcKRfjLEHxq9UQRCn3HNBc7b4+uPgK3+Uv0kZHqum/jjJTkhYPr
         ZQc+KwC5sRe6xOHZblmvSRziqeuC7FTQ1eK5T5GtEjv9lvFKI0dVbayhiJkbZkwDjU4b
         i8dz5s8EV+FFeJuwEHomuq4IhCqH6kGWfQ8b6a+XQ/WEpXIZnb2eZ9BJoT2tyySMnCjn
         QRBQ==
X-Gm-Message-State: AOJu0YwM6vqt2pQLpLdeM/YE1px7f3NZfjyy/GxJAqxs7HYnFSbLO9pY
	lm0YPfcozI/egKXHo4yChkB3c2DkkxX2jQyOTpR43J9cvszqPpHdWAkcBbntC8ort3O/umvsVbg
	Cmc1W4CVP3Aw1lzus6WAPcDUR7egzNg67MCAn7W+d235m/9/vLwJjXtxtDa1RP5Y=
X-Gm-Gg: ATEYQzxbi7fjaffHyrEf0urhARC2+uw7XgDFDYGmu+Ai85YUSorwNOFLMc1jxB3ZhVQ
	WNcSMR0NgEj4kr4o46MRG7AINapjY1rtprQ+YR0CLGCxtL14BX1EXED5nw+3ZKPB4TOe1GQPX4c
	37LayPDaMpsl+/znO5CaBGLgoAG0RTjHxhF55bipfif6B3/9dN/5SY43fxMVZfgFlb2av8yS2hw
	L7xT6OCLvD0LALZB+pzWxU13lMFs4ck7+r31QKDRD3sX/x1hEzjaQ8YxBklA/leH0tB95tMELn0
	ULFr/IuhzRCrDPpjPNhPhazDHeV5G0g52fu7qfEQm2hO/1axSXrlFQIkIo3SGs0VQ1AjaFiUgYh
	IxEMHCdNh5KbzVmZPKxH8UifkXvvkgoD0r+d4XnKN0p9I6sP0bbLH
X-Received: by 2002:a05:6122:4d09:b0:56c:d757:a045 with SMTP id 71dfb90a1353d-56cde41dea4mr5640602e0c.9.1774279050040;
        Mon, 23 Mar 2026 08:17:30 -0700 (PDT)
X-Received: by 2002:a05:6122:4d09:b0:56c:d757:a045 with SMTP id 71dfb90a1353d-56cde41dea4mr5640558e0c.9.1774279049606;
        Mon, 23 Mar 2026 08:17:29 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:f9a0:d7e2:7eb6:79b5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bd923sm35936993f8f.12.2026.03.23.08.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 08:17:28 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 16:17:07 +0100
Subject: [PATCH v14 01/12] dmaengine: constify struct
 dma_descriptor_metadata_ops
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-qcom-qce-cmd-descr-v14-1-f323af411274@oss.qualcomm.com>
References: <20260323-qcom-qce-cmd-descr-v14-0-f323af411274@oss.qualcomm.com>
In-Reply-To: <20260323-qcom-qce-cmd-descr-v14-0-f323af411274@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Tiwari <quic_utiwari@quicinc.com>,
        Md Sadre Alam <mdalam@qti.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        brgl@kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2295;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=V/kExSnp4gLekFUspVMuJp40Wa32cu/zESSu6vck61c=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpwVl6QfTigBEi1Zc5gOSQ9IftU0OPPEl1W3ef7
 b6wcRCD/YSJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCacFZegAKCRAFnS7L/zaE
 w7Y2D/0QKbhZRYhcMhr69xVe85Z4XZd02OV9nYgjGvsH6bUYJa1RxEGRohMY8QLlrjoi8dFTyZw
 y7SqGmySgWNrbtzUjCRF/rJbr+0z8tlL1uE0fXfSCld0aYhvT93+BeMEhlk+tckz0LWuW0uaee/
 mKusUzi/sh2bEJpAjpij6K+bwblInYCOFdR6p/RG+1HVPJ0weGr76HH8rrgOycsWu3gtMD2xpSY
 zxJnT+ReClDG02MzCZfNv+Q5jD7SFU0yjFwFa0Nd8fudUegf2ILPprAU9+Kx/vshFlFxtSivu+u
 oOnQlwXYPqnwDCt2/52K/AVSb+QhONewfHIyllbjitznnPIv50Rv2MfSUtTxFuEI8LJFz0afL+l
 cVNRXJnIdt52impuo1GsO8S3/tyL8NTHjmnIPkmGK02GUfN53nWfK0pDgkDKsRg0ISUCkO8gCsh
 PQ+7Tc1nSxwQC1yE0N1jJbVbp2er9B1MURyjzb3GqzHya/HK521+qtDiS/+7N2rxxvezdGvrbFj
 4zxOaacXAnRs93zIFxwUM5Z1IRbPVtF59BJVaAK+KBK+mUaqU+9bTkc2/Z3hHyS5DN6zC/NQCpe
 xmXWa4AXrXh6bGJW8geiOsq/lgT91X27oOYCn/cqA//2OSdafTRgI00nDZqmoGy21SVj3vo+2kH
 9CbBw4h43fR+nyw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDExOCBTYWx0ZWRfX5ncWo+FMbyYP
 F3wsHchwfRTrfdr5T4h7CK1qn+gBoKhM65YHBSwnCmOAM9x/dTedETZULLEZlugLMpHg0DuFqd0
 aRVSP7lnDgiLVMhy0E/BsES2Ik4vI9OdvwHn5wOfTU9IkuRlhVAOZcbUsadyOpFXD3M/TMeahwO
 vct08BdictG6M2x6wovjsD1vmVqO+0mRUedPfwnoZzX2BQsHhkYYr/3AnXWYFkpdexDyVptF9AU
 2JuQ+eLtBB9XT9PJCVw7OnLzh+gv4BJb+obLwjf3LKN5AoA++llSF5X9vfrVYpoDXjHAH8O9Mp+
 u8+qlOgQU89fc62h8mT6yzYAolzRJFPXqFjfcbFBmWHN4zdxYBwE7o2+tMmzVJseIEaaTD2E2bP
 VfMQIoPisCt9a3VeqR/9jN9S29r9FVs/sRkuqy99nZpOmHy81z/K9PSzIWvefLBY1YUNopL3/FA
 eN+PM5NtOy0PizcyelQ==
X-Authority-Analysis: v=2.4 cv=eMoeTXp1 c=1 sm=1 tr=0 ts=69c1598a cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=XeVHrwws4l7kqE2Ex6IA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: TYBgJdcufiXonbwhiwjZH1FXDK_NaIXy
X-Proofpoint-ORIG-GUID: TYBgJdcufiXonbwhiwjZH1FXDK_NaIXy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230118
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9600-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D73A42F941E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There's no reason for the instances of this struct to be modifiable.
Constify the pointer in struct dma_async_tx_descriptor and all drivers
currently using it.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/dma/ti/k3-udma.c        | 2 +-
 drivers/dma/xilinx/xilinx_dma.c | 2 +-
 include/linux/dmaengine.h       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index c964ebfcf3b68d86e4bbc9b62bad2212f0ce3ee9..8a2f235b669aaf084a6f7b3e6b23d06b04768608 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -3408,7 +3408,7 @@ static int udma_set_metadata_len(struct dma_async_tx_descriptor *desc,
 	return 0;
 }
 
-static struct dma_descriptor_metadata_ops metadata_ops = {
+static const struct dma_descriptor_metadata_ops metadata_ops = {
 	.attach = udma_attach_metadata,
 	.get_ptr = udma_get_metadata_ptr,
 	.set_len = udma_set_metadata_len,
diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index b53292e02448fe528f1ae9ba33b4bcf408f89fd6..97b934ca54101ea699e3ab28d419bed1b45dee4a 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -653,7 +653,7 @@ static void *xilinx_dma_get_metadata_ptr(struct dma_async_tx_descriptor *tx,
 	return seg->hw.app;
 }
 
-static struct dma_descriptor_metadata_ops xilinx_dma_metadata_ops = {
+static const struct dma_descriptor_metadata_ops xilinx_dma_metadata_ops = {
 	.get_ptr = xilinx_dma_get_metadata_ptr,
 };
 
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 99efe2b9b4ea9844ca6161208362ef18ef111d96..92566c4c100e98f48750de21249ae3b5de06c763 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -623,7 +623,7 @@ struct dma_async_tx_descriptor {
 	void *callback_param;
 	struct dmaengine_unmap_data *unmap;
 	enum dma_desc_metadata_mode desc_metadata_mode;
-	struct dma_descriptor_metadata_ops *metadata_ops;
+	const struct dma_descriptor_metadata_ops *metadata_ops;
 #ifdef CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH
 	struct dma_async_tx_descriptor *next;
 	struct dma_async_tx_descriptor *parent;

-- 
2.47.3


