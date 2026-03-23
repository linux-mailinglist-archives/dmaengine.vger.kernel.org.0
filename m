Return-Path: <dmaengine+bounces-9604-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +D4gCEZjwWkDSwQAu9opvQ
	(envelope-from <dmaengine+bounces-9604-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 16:59:02 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8022F7368
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 16:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 505C830DD950
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 15:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F613C3C16;
	Mon, 23 Mar 2026 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WXc6WxQv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F6L2IfoD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA24A3C344F
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279062; cv=none; b=rnWaEn9Bwoev3nPqGK9u94I4+HQ3tJHlijDCikgkG5wr95ZFuPL7a8cO9geqzX5CTxoMIXvNHJdY8wQFiFEiOFeZYZRbmxoTyrwoI0t4l8azGT58/ze2Y/fLg4bG5TD0CDMrzcLeIm9dm1ap6zMj+ojtb+1eBurX7/ybKj2w18U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279062; c=relaxed/simple;
	bh=rWOE47026mczpuQ+OpCmY6UmFXFZSFt73L3FX2KDFWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c19a2u1v/ldSAiEqMzGgjMUv71sc7qj+Wf0OlwZVMyl4NEgCkPa7lyBdJQcaYxA2uktQyeLw03USrgAgyep3//Bt9CAGaiftGBixfaM/gpV6L3cVTkev57OmR17iq2Lv6Ra0+4gcpC00OCJuxAuGo7G/plkiKZns4oOE9RSxPGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WXc6WxQv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F6L2IfoD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NFGR0N3474150
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2y0wDnbloqZyr+tffy5v2L5LGuKsXqmk7G5sbV/+toc=; b=WXc6WxQv7ig6fn+V
	PQzxiOo7hKM+KAo3gzR/j4J1/VPTZZtuPtGj9IBeLdUWMrQIlHdm6K+oNTfnKUm4
	Ax92xwqHsVffCFnJaib9h986D+SSVO+ZIO5n7uuUwmG1VhRgoRpzY+RMOIPaDIql
	hgc5TWBopFjr6zB2U7gXWl7WHaKMrtZoHII41tqSI060kYmaAmMLf6yc9ij3sOhA
	YVWasxLl4izCv9TZqafJqR+4wtb5JFMTYwKJCk8aPEtm9Yg4tVPgAH1vM2H7mL1S
	kzQKP4V1Thvo5BN5Wf7qLeb4io1ie3Myb+enGccJGyj9nn7FmyQJs9hVrKfNuRLM
	1AdF+g==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d355w0pug-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:17:39 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-951767f6e76so777583241.3
        for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 08:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774279059; x=1774883859; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2y0wDnbloqZyr+tffy5v2L5LGuKsXqmk7G5sbV/+toc=;
        b=F6L2IfoD0tQZ0dbBR9il4hWvTezAySCa0Yh8MMoQDugTaU0vIy9cArFaNSEPUMv5Mp
         ZCRWjt++NY7OaQ/MAnoWu88yFidhYItkjWEIydJYAlO9j1ARkNAGzSmIpUnl3baY8s42
         XcVuBtJ96W882jBdO8SfvLNWybVRYrTFH/F5zJQp4CPARf2rQqIJxo4QBqxfrqOscc6F
         XgwTf5NFJKwKczfTPq3uTtw6W7YbL6LogZL5GL1QpEgQh3WyzO4daAjvEK17QGQr7Dpe
         SLoJHCIdnUL7+KX6ZBG0V76mzXEAx8WnRs7YllUAL73HJCkki8CqLS4xJxx5wdqAG1Ew
         vt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774279059; x=1774883859;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2y0wDnbloqZyr+tffy5v2L5LGuKsXqmk7G5sbV/+toc=;
        b=DK1VVqziOxBH+6+Ti1UrBJr+ofV2IAPg1QAuNfsjQ80rtPVM9w3lVHRmQiJfx+gTyM
         khQwk+k1a3Aae4AI+o/DpzEUtKr2QHb7MBW1rmwB8IBgqgLsM6/tszENKlwkDs/5NsDJ
         ROD+J5agJu7b1lupVEnbC9vbUXutftK3kfKexTHFhEJtW5pHMlT4PKBC5tzUxxYzJRyI
         zMN2mL+kp65t7FnXT3ofUIcMxAWM3Ws85ew+E9sRZejWC0uSPo7L7GE2t4to+o4p+EII
         7l7Jt7WVH8K9X0K0QpDImQ1LWROG+Fz+iT8qazyotJMr3r/PKJXRF5M84P8L850V1ZBu
         Qa9Q==
X-Gm-Message-State: AOJu0YyvGbGqa3Rh2zcI4yeoDSo99N6lySb1uFjBylu6OMgu+pvTBpOj
	7d4wKSmRWwu22VIGEZHUmJQXJ3Uv8laqGI5XnVMJFzjxYIkzn5kD8IAqYpkJ7sjSZISddfHJXTq
	Y8jynV7/PHRorYZ2KAg2iCvX7utUA6+KVTuTJhaDS3aYUBoYJqxpsxQOvB78v4EisTG6GFnw=
X-Gm-Gg: ATEYQzztQKyvLp7n04WYLx8sEr6LQFikb8rcH5ydWGjZfVG5MzMdrgBoBeuUJLKX1vL
	KQ0+6b495+gZJXjI+z/xCfacmPaSaUhjSgvKe2ZNND7UCipDf+YpP7qva39xLJ+XtHwfnY5L2US
	pU4AzLWbR8763byd2gjprWqkV4YYmgOMzXEQTuUpmF2PFtPuH1gxCXyCu7BK6Xj/PrmRu6txRpN
	yvvsACFLcuu7+24Kp4ACP8TU3PGao72Tq0OpzPTXytL1C+dpnsm/WRwGzmiVi1bKsYSXWKnDR32
	2uxGxQwI7LQkOvvb5KRR/bmRWEc2gnZ02vmoGb4RWyuzG9ZG/eQT93PoZ7fMwxVDR9hEIH6mUM0
	U4XGvwiRAISnbLz7/0JT95lSv5mXoi6kT3Ib5am0CGrdYAyIoU2/G
X-Received: by 2002:a05:6122:d1e:b0:56c:d59a:cfe4 with SMTP id 71dfb90a1353d-56cde47e3camr5670674e0c.17.1774279058944;
        Mon, 23 Mar 2026 08:17:38 -0700 (PDT)
X-Received: by 2002:a05:6122:d1e:b0:56c:d59a:cfe4 with SMTP id 71dfb90a1353d-56cde47e3camr5670592e0c.17.1774279058409;
        Mon, 23 Mar 2026 08:17:38 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:f9a0:d7e2:7eb6:79b5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bd923sm35936993f8f.12.2026.03.23.08.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 08:17:37 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 16:17:11 +0100
Subject: [PATCH v14 05/12] dmaengine: qcom: bam_dma: add support for BAM
 locking
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-qcom-qce-cmd-descr-v14-5-f323af411274@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9224;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=rWOE47026mczpuQ+OpCmY6UmFXFZSFt73L3FX2KDFWk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpwVl/U2pDgQv5YxJHbZX0VcINEtapypUTtW6+Q
 G08A0O5glWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCacFZfwAKCRAFnS7L/zaE
 w238D/9yCNG/4+r3GzaQR/gjiJCNM1R+ndI3hsQQnE2EU5YjB9lPbmyo+6Frz5Mnxa6DJAxmprz
 ASU3k8COi5+hBlGRgZOFGnObO+ztW7s6w3gSYgn0KnMhJ0Eb5SbHTE30ZecNSCV+wZlmhztJ2xU
 dq8dURfoGz/hsU/nK0Uqa/eFXYkWwkHHzsf8/FCDwgUVFY93K1DJA6AEsFiQlgG9WOBvegOGk8b
 LxQXXZTF7Qnu0wv9pz1iC4Em8Lrg5svC1n31PLNPUh8LGEeAyRp4rDtbIZa5zsvI+MHFwCKNV3P
 kvurpbgqj6DoYiX3OFwFVErqJ10G4UBuLpLWePWcdZdmV1FzVoV0GrCYnH9lErTJxKVqkj5h+7/
 BGHa/lVEN8WjuXTiJaoyNrUFlFgt8DurWofp1OOJ7L+ho9Kot3Gb96cyV2xRqYeHj7zkLPnb94R
 FH+/A9IPopOM1CbQl331/HFRfA7rNzp5hLJAeH4QRv9qaz5Ohvd2wQ6pEjgqw1VGjYUURzErbcE
 l/Kfjf/IX13AFA3sA6pdwoQZMkM61DxGFxngVVQoe0kH2akN0lt7/AzDCzlnoZm0M0TQDsFhUSm
 hAWF4RnTvLK/wjeuniT6zb7uTWMhXrzeIhioku2Rb5+buHYxOuIHOwrMe0pO+AlS5CDL4hTW5qr
 y6v1a/Xu/M/OULw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=fq7RpV4f c=1 sm=1 tr=0 ts=69c15993 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=RdU2YfPBjIXQodyA8iAA:9 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: SvV1wWCEaWks473Cd7Gon9ja6IJiEs5g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDExOCBTYWx0ZWRfX80A49S4guJmT
 azm032BF0nBDCBv/0fIPR0bSZVa5RPOCt4UEM+/Y9eHFlJ7kH7955VmzstNQNdfPPSiD6ufhAhX
 h3aNYkbzn4p8YzDascnO/AYtnQQt5+nutZ/wxEMK8FqXO4ImL16zQjSWrX475MjqLB9Eov29H5K
 SOqwRkpB1FmuCWIZ2tc1TwHewOGEgED8NMz0SsVemj3CccQB8Q8u0PCJYiCw/Y68HSSBwRDrWtR
 s0akPf6hbvNB31FBgCCVWz7b9JIO5H00udAyGE2F5q1eMT8OlgirWwnYJHCjrDaKzThg7y2jEIy
 w4xTE8EJGqlc8oIq22g+30ohBlzOsPtkX0ztSsv/1waSxw0nPgUn0LAbCm0LPGo7qTL0OOYyG/r
 G/nOvtcVsVaU9HUcS928BKU2k2fzqMs9Gd9PgrzjMZTo87xYPugSPWTfGpmZSWZszxL6GTV7sKK
 1fkxPX98DfEDa72kxIA==
X-Proofpoint-GUID: SvV1wWCEaWks473Cd7Gon9ja6IJiEs5g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230118
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9604-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
X-Rspamd-Queue-Id: 2A8022F7368
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for BAM pipe locking. To that end: when starting DMA on an RX
channel - prepend the existing queue of issued descriptors with an
additional "dummy" command descriptor with the LOCK bit set. Once the
transaction is done (no more issued descriptors), issue one more dummy
descriptor with the UNLOCK bit.

We *must* wait until the transaction is signalled as done because we
must not perform any writes into config registers while the engine is
busy.

The dummy writes must be issued into a scratchpad register of the client
so provide a mechanism to communicate the right address via descriptor
metadata.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/dma/qcom/bam_dma.c       | 165 ++++++++++++++++++++++++++++++++++++++-
 include/linux/dma/qcom_bam_dma.h |  10 +++
 2 files changed, 171 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 83491e7c2f17d8c9d12a1a055baea7e3a0a75a53..309681e798d2e44992e3d20679c3a7564ad8f29e 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -28,11 +28,13 @@
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma/qcom_bam_dma.h>
 #include <linux/dmaengine.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/lockdep.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_dma.h>
@@ -60,6 +62,8 @@ struct bam_desc_hw {
 #define DESC_FLAG_EOB BIT(13)
 #define DESC_FLAG_NWD BIT(12)
 #define DESC_FLAG_CMD BIT(11)
+#define DESC_FLAG_LOCK BIT(10)
+#define DESC_FLAG_UNLOCK BIT(9)
 
 struct bam_async_desc {
 	struct virt_dma_desc vd;
@@ -391,6 +395,13 @@ struct bam_chan {
 	struct list_head desc_list;
 
 	struct list_head node;
+
+	/* BAM locking infrastructure */
+	phys_addr_t scratchpad_addr;
+	struct scatterlist lock_sg;
+	struct scatterlist unlock_sg;
+	struct bam_cmd_element lock_ce;
+	struct bam_cmd_element unlock_ce;
 };
 
 static inline struct bam_chan *to_bam_chan(struct dma_chan *common)
@@ -652,6 +663,32 @@ static int bam_slave_config(struct dma_chan *chan,
 	return 0;
 }
 
+static int bam_metadata_attach(struct dma_async_tx_descriptor *desc, void *data, size_t len)
+{
+	struct bam_chan *bchan = to_bam_chan(desc->chan);
+	const struct bam_device_data *bdata = bchan->bdev->dev_data;
+	struct bam_desc_metadata *metadata = data;
+
+	if (!data)
+		return -EINVAL;
+
+	if (!bdata->pipe_lock_supported)
+		/*
+		 * The client wants to use locking but this BAM version doesn't
+		 * support it. Don't return an error here as this will stop the
+		 * client from using DMA at all for no reason.
+		 */
+		return 0;
+
+	bchan->scratchpad_addr = metadata->scratchpad_addr;
+
+	return 0;
+}
+
+static const struct dma_descriptor_metadata_ops bam_metadata_ops = {
+	.attach = bam_metadata_attach,
+};
+
 /**
  * bam_prep_slave_sg - Prep slave sg transaction
  *
@@ -668,6 +705,7 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
 	void *context)
 {
 	struct bam_chan *bchan = to_bam_chan(chan);
+	struct dma_async_tx_descriptor *tx_desc;
 	struct bam_device *bdev = bchan->bdev;
 	struct bam_async_desc *async_desc;
 	struct scatterlist *sg;
@@ -723,7 +761,12 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
 		} while (remainder > 0);
 	}
 
-	return vchan_tx_prep(&bchan->vc, &async_desc->vd, flags);
+	tx_desc = vchan_tx_prep(&bchan->vc, &async_desc->vd, flags);
+	if (!tx_desc)
+		return NULL;
+
+	tx_desc->metadata_ops = &bam_metadata_ops;
+	return tx_desc;
 }
 
 /**
@@ -1012,13 +1055,116 @@ static void bam_apply_new_config(struct bam_chan *bchan,
 	bchan->reconfigure = 0;
 }
 
+static struct bam_async_desc *
+bam_make_lock_desc(struct bam_chan *bchan, struct scatterlist *sg,
+		   struct bam_cmd_element *ce, unsigned long flag)
+{
+	struct dma_chan *chan = &bchan->vc.chan;
+	struct bam_async_desc *async_desc;
+	struct bam_desc_hw *desc;
+	struct virt_dma_desc *vd;
+	struct virt_dma_chan *vc;
+	unsigned int mapped;
+	dma_cookie_t cookie;
+	int ret;
+
+	sg_init_table(sg, 1);
+
+	async_desc = kzalloc_flex(*async_desc, desc, 1, GFP_NOWAIT);
+	if (!async_desc) {
+		dev_err(bchan->bdev->dev, "failed to allocate the BAM lock descriptor\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	async_desc->num_desc = 1;
+	async_desc->curr_desc = async_desc->desc;
+	async_desc->dir = DMA_MEM_TO_DEV;
+
+	desc = async_desc->desc;
+
+	bam_prep_ce_le32(ce, bchan->scratchpad_addr, BAM_WRITE_COMMAND, 0);
+	sg_set_buf(sg, ce, sizeof(*ce));
+
+	mapped = dma_map_sg_attrs(chan->slave, sg, 1, DMA_TO_DEVICE, DMA_PREP_CMD);
+	if (!mapped) {
+		kfree(async_desc);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	desc->flags |= cpu_to_le16(DESC_FLAG_CMD | flag);
+	desc->addr = sg_dma_address(sg);
+	desc->size = sizeof(struct bam_cmd_element);
+
+	vc = &bchan->vc;
+	vd = &async_desc->vd;
+
+	dma_async_tx_descriptor_init(&vd->tx, &vc->chan);
+	vd->tx.flags = DMA_PREP_CMD;
+	vd->tx.desc_free = vchan_tx_desc_free;
+	vd->tx_result.result = DMA_TRANS_NOERROR;
+	vd->tx_result.residue = 0;
+
+	cookie = dma_cookie_assign(&vd->tx);
+	ret = dma_submit_error(cookie);
+	if (ret) {
+		dma_unmap_sg(chan->slave, sg, 1, DMA_TO_DEVICE);
+		kfree(async_desc);
+		return ERR_PTR(ret);
+	}
+
+	return async_desc;
+}
+
+static int bam_do_setup_pipe_lock(struct bam_chan *bchan, bool lock)
+{
+	struct bam_device *bdev = bchan->bdev;
+	const struct bam_device_data *bdata = bdev->dev_data;
+	struct bam_async_desc *lock_desc;
+	struct bam_cmd_element *ce;
+	struct scatterlist *sgl;
+	unsigned long flag;
+
+	lockdep_assert_held(&bchan->vc.lock);
+
+	if (!bdata->pipe_lock_supported || !bchan->scratchpad_addr ||
+	    bchan->slave.direction != DMA_MEM_TO_DEV)
+		return 0;
+
+	if (lock) {
+		sgl = &bchan->lock_sg;
+		ce = &bchan->lock_ce;
+		flag = DESC_FLAG_LOCK;
+	} else {
+		sgl = &bchan->unlock_sg;
+		ce = &bchan->unlock_ce;
+		flag = DESC_FLAG_UNLOCK;
+	}
+
+	lock_desc = bam_make_lock_desc(bchan, sgl, ce, flag);
+	if (IS_ERR(lock_desc))
+		return PTR_ERR(lock_desc);
+
+	if (lock)
+		list_add(&lock_desc->vd.node, &bchan->vc.desc_issued);
+	else
+		list_add_tail(&lock_desc->vd.node, &bchan->vc.desc_issued);
+
+	return 0;
+}
+
+static void bam_setup_pipe_lock(struct bam_chan *bchan)
+{
+	if (bam_do_setup_pipe_lock(bchan, true) || bam_do_setup_pipe_lock(bchan, false))
+		dev_err(bchan->vc.chan.slave, "Failed to setup BAM pipe lock descriptors");
+}
+
 /**
  * bam_start_dma - start next transaction
  * @bchan: bam dma channel
  */
 static void bam_start_dma(struct bam_chan *bchan)
 {
-	struct virt_dma_desc *vd = vchan_next_desc(&bchan->vc);
+	struct virt_dma_desc *vd;
 	struct bam_device *bdev = bchan->bdev;
 	struct bam_async_desc *async_desc = NULL;
 	struct bam_desc_hw *desc;
@@ -1030,6 +1176,9 @@ static void bam_start_dma(struct bam_chan *bchan)
 
 	lockdep_assert_held(&bchan->vc.lock);
 
+	bam_setup_pipe_lock(bchan);
+
+	vd = vchan_next_desc(&bchan->vc);
 	if (!vd)
 		return;
 
@@ -1157,8 +1306,15 @@ static void bam_issue_pending(struct dma_chan *chan)
  */
 static void bam_dma_free_desc(struct virt_dma_desc *vd)
 {
-	struct bam_async_desc *async_desc = container_of(vd,
-			struct bam_async_desc, vd);
+	struct bam_async_desc *async_desc = container_of(vd, struct bam_async_desc, vd);
+	struct bam_desc_hw *desc = async_desc->desc;
+	struct dma_chan *chan = vd->tx.chan;
+	struct bam_chan *bchan = to_bam_chan(chan);
+
+	if (le16_to_cpu(desc->flags) & DESC_FLAG_LOCK)
+		dma_unmap_sg(chan->slave, &bchan->lock_sg, 1, DMA_TO_DEVICE);
+	else if (le16_to_cpu(desc->flags) & DESC_FLAG_UNLOCK)
+		dma_unmap_sg(chan->slave, &bchan->unlock_sg, 1, DMA_TO_DEVICE);
 
 	kfree(async_desc);
 }
@@ -1350,6 +1506,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 	bdev->common.device_terminate_all = bam_dma_terminate_all;
 	bdev->common.device_issue_pending = bam_issue_pending;
 	bdev->common.device_tx_status = bam_tx_status;
+	bdev->common.desc_metadata_modes = DESC_METADATA_CLIENT;
 	bdev->common.dev = bdev->dev;
 
 	ret = dma_async_device_register(&bdev->common);
diff --git a/include/linux/dma/qcom_bam_dma.h b/include/linux/dma/qcom_bam_dma.h
index 68fc0e643b1b97fe4520d5878daa322b81f4f559..5f0d2a27face8223ecb77da33d9e050c1ff2622f 100644
--- a/include/linux/dma/qcom_bam_dma.h
+++ b/include/linux/dma/qcom_bam_dma.h
@@ -34,6 +34,16 @@ enum bam_command_type {
 	BAM_READ_COMMAND,
 };
 
+/**
+ * struct bam_desc_metadata - DMA descriptor metadata specific to the BAM driver.
+ *
+ * @scratchpad_addr: Physical address to use for dummy write operations when
+ *                   queuing command descriptors with LOCK/UNLOCK bits set.
+ */
+struct bam_desc_metadata {
+	phys_addr_t scratchpad_addr;
+};
+
 /*
  * prep_bam_ce_le32 - Wrapper function to prepare a single BAM command
  * element with the data already in le32 format.

-- 
2.47.3


