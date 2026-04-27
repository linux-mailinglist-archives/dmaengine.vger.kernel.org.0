Return-Path: <dmaengine+bounces-10125-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPO2Clop72lE8AAAu9opvQ
	(envelope-from <dmaengine+bounces-10125-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 11:16:10 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF6746FADA
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 11:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 77D533006B4E
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 09:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697C03B27D2;
	Mon, 27 Apr 2026 09:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FjHdN666";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dvIGJ3pZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB4B3B19D0
	for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 09:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777281360; cv=none; b=WWAKnLTx+XTYba6C9c9e9/5LJuiuA3zplI3RJeX8WWUaRe9S3qvYZeDFA7FOvp0lWwna3v+jLrBnesMCX9mI9cTVKeXvpdoPQiJvXqRpioXMiPb/0SksXAPSwSi6rZqe/SoqdGyKqsHJEIFRYzI4M6UBXvu+tcRJDSDHk8thVOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777281360; c=relaxed/simple;
	bh=C8t0ZoGUnDPF/P+4BK1Ho5MJ1aexupcCMbMgOX1T0s4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V8H9yLPc7+URW+b4bTETfniUlkeb2Cj7pKVV0uvB+1JlqEnn7mmM2sWEM/xGAGtEiaueYsg/EJyYeJtsBAxpMAPboVoCV7vQsQbGEQbQyw5MIUCtfxnVVVJT6wLjI46hTG+Yb+6aUninDhJ0JGHT8esBPbEw/b3/ytbQF9DprQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FjHdN666; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dvIGJ3pZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R8T9NM1762106
	for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 09:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	51xURu7Zhd73Xm88jAVPEesUyLMnmj9g9fiXS+Fq4Bs=; b=FjHdN666g2PqthR8
	V45oXYnO/VUmnauw2NoEVFfCkXZ6BLY/FCRuqtYw8tizUiOa+W1HYzA4Z8/RSTFf
	dgmqlWgwtCea0K6UId9xn3lF5L3iNwYWBdmnMnyCg22nXILpxWtoAUgW+kvCSpuD
	f34X3hfkp5YRU1q6jelBEDeqlhuVzArpxQPIiP5+92eovPh5CZRFqHL1jbrFS1Fn
	4fxzmN4hwwcIDZM/uX0PfJxe48aP3IVSgYINxZNMGSrLC6wigM5OzjzMOnyFA949
	GPylZTzW/SPD0cVsBwQMQCcgJZX3g0R8J2DxCFfiOja2cyLqqjSE4L4xDYCPaDa/
	212VPw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drpw9d9y7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 09:15:58 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50edf0245b0so31703761cf.1
        for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 02:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777281357; x=1777886157; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=51xURu7Zhd73Xm88jAVPEesUyLMnmj9g9fiXS+Fq4Bs=;
        b=dvIGJ3pZ/MGePlqaxxw9agnOcu6wW9i+e2flhw1VoP2sZR7J+wqVUZ81zlp+I/6ZP7
         bflh2HkQYV0yXySco901ROIrFldfXigP9v46uWgfpo5uJcAk0E45nFHA2y/AwK4FO96o
         MAxMN50GFsAsV8LQson/qMpEyNsnL22j5/v64vRgOwN04RfdBoyttJ1P6BgNDwzEITpt
         9XOThzyT2Q5wy/uw2gOSnEryH+1zS8jqo1wCOouHIx83kB+JNm5zQJsUPzlzog89v7Si
         oItEl34OQY5JFHWVaLe5DJeQ1DLOONZZSQR+AAqjvtfFaoElolTwmvMz8GSKR8krzl4g
         UugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777281357; x=1777886157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=51xURu7Zhd73Xm88jAVPEesUyLMnmj9g9fiXS+Fq4Bs=;
        b=Gvt+MjgrXNUJh4dTOKtc++Xo2jRnj1NSbJBLn2htaznY9U/jimV0tX7OVaiN19Vafu
         CGqZMUJd4s0HinGhzm9qgYvBfUl47aKOj+p/dm8YJROx4UdHspp924LDNRGj5CYPYCwZ
         I8h3/6g7fGyhNDyU8ud11XjoSqazt+bB9On2VTRZ+qyA6ylcI3zARctZA+0PLmvIhVyy
         /QE1G7crZi3MGj7jTme2yVBj4ajnvaqWc8oEfH1vJwqcPyIWHIA/cHHGJniUZDJJWPTU
         ZKTWjx7cERT+4TkXSoLpcJzW9sa8qvPs55GTVs0WRglPG8Tl9rqE+NM1Q3mzEyiRCjuU
         hWPg==
X-Gm-Message-State: AOJu0YyZUPEwyA7uHuhUQGw+Z2f5htm4trAQ8na3SG6yGZ7ldHP83XcF
	1q5h7LrQYHkGu29JHjpGAqRYDpJu7MCLFtIo36Kf6ONPuivrMJ3g32IJ4nJiTHBLXbvpI+GQWbz
	GIRRaXN62d5QyArM5odv1/Dy3KKDrSIpyLr6l79Jp51Kp9Uzf/mftDAjdmnsMygo=
X-Gm-Gg: AeBDieuTo/+eoK8YpA79BkgahetCE9uSp3tjOmFCrncetE33+9nAfJZhhdYv75sAOGj
	ejmw6mJArektZCVAIKyNWMX8/LqJRFTEF/CUrfKSeeEP7ZWQ8EDBiK16ofkX/FFtziIT53rTr6o
	mfUFAbddocOGVz0O23cmAVUhJHDRhYkDIwrxYmU1sJbniHvRk8k/DeZ6apJCZPbcidujR0BYoOe
	2y3O1G9fs2zRCivRjsKNg2XGo93z1mMnT4DXCthPLt1wmpkkVUP8BvXGiEd2fvBEfTDnWX+iKva
	diiFg/sOYW+gNytEamh6Blqk/VK3QPupqC5uXONF3A798bNJJKEhiGp2ydx4kHpGwjI+od9DIZC
	5FHxNCwiWoWGhPfIu3tpHfFL4ACOrckMUISw7ojUn9QWPrJgsQi0PMySagfQpzg==
X-Received: by 2002:a05:622a:4d98:b0:50e:614e:4428 with SMTP id d75a77b69052e-50e614e4711mr465044281cf.37.1777281357571;
        Mon, 27 Apr 2026 02:15:57 -0700 (PDT)
X-Received: by 2002:a05:622a:4d98:b0:50e:614e:4428 with SMTP id d75a77b69052e-50e614e4711mr465043841cf.37.1777281357133;
        Mon, 27 Apr 2026 02:15:57 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:5062:ae86:23aa:702c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a6dbfd4b5sm40559365e9.28.2026.04.27.02.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 02:15:55 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 11:15:34 +0200
Subject: [PATCH v16 01/12] dmaengine: constify struct
 dma_descriptor_metadata_ops
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-qcom-qce-cmd-descr-v16-1-945fd1cafbbc@oss.qualcomm.com>
References: <20260427-qcom-qce-cmd-descr-v16-0-945fd1cafbbc@oss.qualcomm.com>
In-Reply-To: <20260427-qcom-qce-cmd-descr-v16-0-945fd1cafbbc@oss.qualcomm.com>
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
 bh=C8t0ZoGUnDPF/P+4BK1Ho5MJ1aexupcCMbMgOX1T0s4=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBp7yk8aml8U/uuKzfLTF1QDzBZcTS5SzTnwUDLj
 Rf7fhGjq6eJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCae8pPAAKCRAFnS7L/zaE
 w1CTD/9M7yohPsNybzjJthNYlFsJYi4zy+/0cXFzB/USDDxoHI0Q/ANqR+s5n/RQEw0X6x/Dvai
 uDhEojPP3frikVdiOxTx/CLcA940MFKtpXK4vLVncbpz6fhpogA9CQ9rEThuN4kyKkRqvGS8wcC
 wvBnssSbYNel08atGXLfBpNzAehokknmj+RJ1AZnHXP78aF33Pu22gQHnnPTsxF/BAhi18TcIUn
 2N6/j99zOp3zfRUVdDV3F4TXrfOohhTJwN59zDwfZgTrkQ8SmlkkKxrlSYRQflQjRh2TvDzT1ry
 LqhNka0RCVw4tJ6EdYUcmFnzGjqudjIn0NeivlCgGDGocaBmuMSjN6/APtfEs9DZSHimh2eFnyw
 2FJMyLWttOf2k4VlY89PnpOQawzomgb4a7YiHJom2IOZvB4gBu9oNnkPbV0O4rsMR1qcUtNoOF5
 CL99W4qwNpkmPCdwrn/w9KSK93pUyr5TtnviPlpJnMlL5+FU1tO0CCyy7o3nQjSQ8zC2Xp6D+id
 Lxdugtmz+N0vCsbO0QEWZCzNjwrxTsaKYnuGXYTBZj38dzSI/hyc/p2UGTJLtyPbi8OBm/j1AWp
 KPlHX0ahhuPgAHLBvrxEbY2++CaC5bFkRZcoJC48MR+RwsOCZTG1C3hHU71aJLSXODhx70TXnR5
 TBQYsv0L5TdfvxA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: Z0EsGl-Sg-7PnRGrdZF4A46Snh1yT3Tj
X-Authority-Analysis: v=2.4 cv=H67rBeYi c=1 sm=1 tr=0 ts=69ef294e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=XeVHrwws4l7kqE2Ex6IA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA5OCBTYWx0ZWRfX3Pnolx/jhsw6
 nqJnEvWX0r6CzftbrsoRzYANz4ZOXHshQRir0qXM3ibhqwsuoV+9xZ/C1SyMXrJRz10Fg3oLHGy
 ZEJFsQSTYNOjHTTAnLYsgMtdiZe+s9GC/2Yxxz2LRuEKHHU28uiGY3EdsLjplbqGcA+A/nicTeQ
 1h84te3Vpv8ng/lzNJozjYk4iOUSYhdNglSVIp3wuuGo9tcGis+5vwp2UrkBCobDeY0v2KGsckd
 5kE6SVyHQzp+FMF13KpMmMkb05IpawDtdgAfwhLgUOl9V85JsK5Ti8ivWoxs4RXWbySKvH9K8tq
 hi6kZWJ3PA8YzfgnNpjPzSB1v+eSEJhHziDwq2q31V19Uw5NE4bTxKQ/lLwKtRd9i2dWDggKgAi
 xDPPj5P52GlNQ7EiYFHX0JgDHCR8hqTz97N8NZDBlf0No+B1KlyiGLPG3peHhnyn3jwXISMOyCJ
 3wsHwXLGtgzzArLzDgA==
X-Proofpoint-ORIG-GUID: Z0EsGl-Sg-7PnRGrdZF4A46Snh1yT3Tj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270098
X-Rspamd-Queue-Id: BBF6746FADA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10125-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

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
index 404235c1735384635597e88edc25c67c7d250647..165b11a7c776abc6a8d66d631e19da669644577d 100644
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
index b3d251c9734e95e1b75cf6763d4d2c3a1c6a9910..5244edb90e7e7510bf4460b6a74ee2a7f91c1ccc 100644
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


