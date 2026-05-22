Return-Path: <dmaengine+bounces-10731-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGo+LHtjEGraWwYAu9opvQ
	(envelope-from <dmaengine+bounces-10731-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 16:08:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECAF5B5DDA
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 16:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CF25305582B
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 13:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7744C403E96;
	Fri, 22 May 2026 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="loxzmJ+F";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d1ANo+R7"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FEA438FE0
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779457223; cv=none; b=ujKgRPoTL45W6j6c73z6qG7ZpL81TsCHG+gnJJ9IkMfp/vqk0DWeOPVyGqLN4qMkHKnMcZoapIp19FJsj+wq555lAEw3GE+hOEOuW28F7BNhxKbEgkTcW8pEhp6POPSjGVJhffi20ySo8bC65pyAeywww6jzbXnhGPJfewcBuwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779457223; c=relaxed/simple;
	bh=C8t0ZoGUnDPF/P+4BK1Ho5MJ1aexupcCMbMgOX1T0s4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C1XJVnCJbD3Eq96febdZlGTBUj2efxT1PnesFrpcvWkS85RsaKbYynqHyw+oZq1kPFjcH043bIJZY14vtArNaMH/qnEi0fqPvzXCMZZp/9qOij5VN4bSAmVBmEARtutbJ8x0PAcKnFiUCuHvK+4qN8c4qe+zgLXYAIgsZUSXxXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=loxzmJ+F; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d1ANo+R7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M8i0iY3532248
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 13:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	51xURu7Zhd73Xm88jAVPEesUyLMnmj9g9fiXS+Fq4Bs=; b=loxzmJ+F8dCyrSYR
	7Dg7ljkvX446yu9V2U+pR0QIsWFMM3NileByF4whwhNT1IXjGpb9WU3pwtTkb+GA
	rkKm/xIV0ciryNqrrxAngAR0wQBI4EzYvhZ1fYd1NRLSBm7IrizJT7GAiGSfaWdH
	lVGzUe7wWJJOuJNitUDaMGcSAy6cmhV81nhUnXMt4B6ZQcRKsTo+ukFIRTuJ5Bek
	YfsVqyorPD576chs/2OVAvWePmakuvCj3tdpzPtCfDbkeym++CHxLDPmTDyp3Ph/
	esGTKBRC/1kSYhHKOFW47kN2PXuCWvzLzPiNKK6ybRrfndH/wbumbKcbfhIVDW5j
	p2jsdg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea39gw8u0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 13:40:21 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-514b673c8f1so124924771cf.3
        for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 06:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779457220; x=1780062020; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=51xURu7Zhd73Xm88jAVPEesUyLMnmj9g9fiXS+Fq4Bs=;
        b=d1ANo+R7qbuBuS+LZqegVy/9leEcU+TtaAMnQLUpQmiJeg9kYDVeRfHnGKhk3BBjD+
         O32dZ3RUwQU4FjDIs0WgRVcJ9YoLdP8qRxekoA6IokSY0+lSY8YPuj/4hSJW7zMB0HEu
         KahMebV/z0jFHSSeOayfQI2Kh62LWsZPfE+ip11qiuZ89IPDaE69/FztGxoJKVUIP2TW
         /slJ9iFVryU1ieGFNAFmlxr3Ig/4s2Tt4HE5ELZFlukNFAsnqxJjnkSqrScb/ge+7q1O
         gAzYuSwHDPZO95kRrJAXBrOgtDrh/tkkd4vPIkexISEdTZKmzGyFYKKro9+ChLnVZKdf
         f95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779457220; x=1780062020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=51xURu7Zhd73Xm88jAVPEesUyLMnmj9g9fiXS+Fq4Bs=;
        b=ezKJlKTC0AIqakKPvMt+yJ/yPJysRI1rVCTb7Ows1kTZ0oA5ydqsbmK4ig9u8jmeqR
         eAmRov+csqq0oT4elJb+sU530nka8ohN/Sw44Ryd1f0977irv1RB4bFfIrNxz6eE/Ppj
         eYX9a16qlmT40z/MoU35FvcAy8vVlNRsPw+PRUGGAf/jYi+f0XkzU1B6xKzVikjAwJxY
         beE+5lgA49Zw1qXVN5CPlfuewQEzoLXKoUZ+AlVhQDlRC8Ok+dVWDQRbztT4LK6jrMTK
         0AUMorS6LtsNo9IxGzNxLf986VyT8s4LHR+ApNHrQZwxj/XiYt6go5Kpe0r46GDHn8ea
         krkA==
X-Gm-Message-State: AOJu0YzeHDDBnJYChEK2Po3c/tnTYMN/WytJZmJRYmHGN5bQPXSy2v+h
	EEzOFgR+fhhLPmauWDAorkQxb6vYm40QrF2UgFYrnklVqalQZ+3beWTT4RXfzczL0x41u7l+AGJ
	5nYvoIXw6wuX3E0EDWoOqdHUgPzWWf1MvSxbktHdu2wD0+ipi+kRI4q02XeXcRlY=
X-Gm-Gg: Acq92OG7FEfkmEV41naSYTkgM81jwffsL9F2AYtmMYYUtf4FFzsPesJCvOOCvqDm1O7
	nckFj5ZLiVGDjEhCUPeSwBCJF/RcKN6jZFmhH3UVSVQ6yDQFhaYdGBlcMmNsItgoxn/1WmfvQQq
	II7n4dyvMIQ1MISJWOLuymKQMwOlvOl7QNUICzJEJSn9cbCEGtjxOfZrqMHugq6LgkvacMt9h9o
	o/jfAgJwTQGXej8CwCgGRJqmj4adQ2w91FVGILwzbdYogzffzYvhcPnyIblt4rkXqirExXM7g2I
	HSmQ6TRej16pruYrKtdE1iwkEN/+xRrWqdtzsQXFUGFXFomR5pjKOSoenbagqQ4jmK9OMFvmbUo
	l2L4pGnFfLT8K8PgMzrwt/y5pOO0lBxynjiKsF7+7ftSA4Or90QJGZ6nmctoU
X-Received: by 2002:ac8:5cd5:0:b0:509:2b02:c1bd with SMTP id d75a77b69052e-516d442805fmr56740321cf.12.1779457220176;
        Fri, 22 May 2026 06:40:20 -0700 (PDT)
X-Received: by 2002:ac8:5cd5:0:b0:509:2b02:c1bd with SMTP id d75a77b69052e-516d442805fmr56739721cf.12.1779457219446;
        Fri, 22 May 2026 06:40:19 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:2fa:6280:a48f:fb37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454c600esm44912825e9.3.2026.05.22.06.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 06:40:18 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:39:54 +0200
Subject: [PATCH v18 01/14] dmaengine: constify struct
 dma_descriptor_metadata_ops
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-qcom-qce-cmd-descr-v18-1-99103926bafc@oss.qualcomm.com>
References: <20260522-qcom-qce-cmd-descr-v18-0-99103926bafc@oss.qualcomm.com>
In-Reply-To: <20260522-qcom-qce-cmd-descr-v18-0-99103926bafc@oss.qualcomm.com>
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
        Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>,
        Andy Gross <agross@codeaurora.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        brgl@kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2295;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=C8t0ZoGUnDPF/P+4BK1Ho5MJ1aexupcCMbMgOX1T0s4=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqEFyyMyvLLfOOTHigPKtrLIkfFqjpy/Vy1HESB
 YKLV/xlDEGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCahBcsgAKCRAFnS7L/zaE
 w9XEEACBI+WYfAdsUiua0bePagUO7ktC4LRT4cbP1YIPs4CKHpbMR8GPY+M41nEEKYqHYoK2eVS
 kXUAk3LTJiWCPIoZzrtNEy2ney36HCmtBt7yuln5eTzdcrjqrf8C01YI0hCnniB4CQlu4GzkCC5
 ILveBVQ9B77lGzfz89+RS1tx5jtoBtcdVOO4pzNgG2aDmK+Efvsg84bRoEy92CYOZWDp/7eDeVU
 aYwRnFCyKeE8lIjYZt6pS/lZEPRt03Z/YELtvjDq2moubGDEb0BKU+AdoNoqm8IdwbtiCLybHz8
 13nKV+WcfefcCDjxFHa36y/xB7ikS+PTYQ1QcuDGeEywOwobW3ZvyV55XOfNXMXJrN5Gk6RwxGZ
 dimIHmQEp0/HUTc1HlnCZLhVRYZfjrx/RGcvyyYv862Uc0wT92ffexINzv3/WSbF7siR8smt/pZ
 DE7KuF/X74xOGRjs2URJep2zLHeWWbQohK70r0qD3aoQzkgIlDxr9RuAI8M8OPsY70D1PR09RhN
 sLIe38e854qqBne5Yl4k3pMiXQhaclJYTrBrMUVBxuMp09i2IOxXsifKHqeqqlbN3vsx3dA9Udh
 uvdxMg7bEOdCwssfe8gqSXTFZMestJCULF0Cse4mJ6K4+1Qt16N/FdbORA1DUWLmZhaTnYdCFFe
 5sCLfu5SfezeBPg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=Yr8/gYYX c=1 sm=1 tr=0 ts=6a105cc5 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=XeVHrwws4l7kqE2Ex6IA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: Epy9y2_gVKr8Q2jW6qgkfmoK7A1DOSFr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEzNiBTYWx0ZWRfXzzShFa2/6LDJ
 mQYvv4KbjRbN+L0EqmL5+4lq22NQyNdH5Ory8TpKQwe2Y/jQgsdfZMa8+acXPOCgR3fTsRs4862
 3eFYOqMDkWEq4U2KG+o29v1sjRj75LeITI0/nHACYjGVU6D23fowOaEq1CObbzuedAFTKGvJjpf
 vIpCWxC9pQMvupjBFNXS+yHL7j30gr6KmScvpsoI64gtxYahhQLhwzuMFnNma7+gdvumg/wND7C
 gHvHOJys7/pezaTP05mDfC7JU24vvJzOrNB8V02Ti1lUCdmbiCw1mxVJKDJSH89KK5UgF9lirnu
 HLIFvk1S0L/V7hDPwKbTfFulZzy8JrlQE03AE+P0OmzAzwEJ069cgNqy0+DrHf3yX6lMqvY+agW
 UEHjSp/sjZHXpBe3LQKh0/P+HEvN1otF9cQ4spocZSKbqzzFrMpbufEbJlzDYQW/lSh/uzKH0gG
 ft/bsoMVWLYrW+dvzkw==
X-Proofpoint-GUID: Epy9y2_gVKr8Q2jW6qgkfmoK7A1DOSFr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220136
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10731-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0ECAF5B5DDA
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


