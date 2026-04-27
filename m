Return-Path: <dmaengine+bounces-10126-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BdYLU8q72lE8AAAu9opvQ
	(envelope-from <dmaengine+bounces-10126-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 11:20:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B9546FC57
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 11:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 772463034EC5
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 09:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F013B2FDE;
	Mon, 27 Apr 2026 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZWJTr3pX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kv2/O+Oy"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3762C3B19B9
	for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 09:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777281363; cv=none; b=fu5CwetGnhxEkywy0hJu2yvXBcZxE67uPD5/rVrgo1/slD058IzlCH2LdVLyGBHhPdiS0HBENrbToYfBxuFgkx94cVe6uC35qin4pBI+7MSpReOkHhl3bpNQz/MeKUQbAiLAAmvcPMuLcsQmMaASaniv9uqynwSAGMfNF3FVHtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777281363; c=relaxed/simple;
	bh=YERqA6ytYIBXeEnEVHuNkc6pRniKdplpfqUBYqgG5Qg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qaRq2Cktf3/9YVwQwB/lhZU4HmiMlaNrz6Goj1jYVCzpM6lYZ+FoDEvvREQxFiNUpO214jEFmOfQep/SGF4pFt1FWi7/ti3RuyYV+j8epAZBekr0mPGXaunJb3l6Hc4XMc6OmH6UVJDuecij/p8VjepbMrEs2VMp7tBpLIwi4Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZWJTr3pX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kv2/O+Oy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R8TAxI2793059
	for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 09:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YJhp9RjB1CYlks4dixIKSaB1cc2NAImnrh4QNBeenlY=; b=ZWJTr3pXlqCC2RlR
	FGlJ6AX3AXqMklp6Ymy372sFwRBv6WSMo5pagYddmlAHtIDWQI75fUnBQTV9YFQN
	vdCRsvcxKfFFotp55zhr3VXiQknk8BIaAE9MdeKzGg+ZYti3R0E+Te9bKfoMuWu2
	B0HsvlVx8Nx6U/dGOKH5Z8e/nt4L7SG7XSHV2PIbr0rjfLPYEex1wl0Uia0vGPjb
	PjP2zpHcypgvJOSuF2mxKzDX4D6vydWeG08p8pwzGmtb/p85Vpg0HtcYDb/FKBQl
	Gqf1Kv+HSIqO/c8Nx1bPQl/9Bd5+2RuFz0P0mdnnuCIGA5KerLvq0hWhi1IIHGra
	XscZXg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dsa4uudgg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 09:16:01 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50e592e833aso113232871cf.2
        for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 02:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777281360; x=1777886160; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJhp9RjB1CYlks4dixIKSaB1cc2NAImnrh4QNBeenlY=;
        b=kv2/O+Oyc96TKw8oVetUWHIs0jw8fGViA9VXkpiGiq+NzOfkKOEOJbmLopHRpvDxWv
         D5VBdLfnsNK63jvzHzlxgal0Xd45igA6BWR49Jb29gO6P/fgJh66m0M1ClSJ/FTTEOb5
         8vIWX2Dk9y4Phnk7Ceww8ZPNx/MSNUn+p0wbcopMw5cY80yA4ROcOZULcPpLL3OKfmRq
         1mhZdMMRxd38gxTk3aWHd+I5Lut/I3KP//kHPcSjgtrSKdURfkC1cFqH/UeV52owPM43
         els6+wEcSIb3DENf/gVrk8kzQUMM6RW7vVCsGXB/7SsYR2huHYPFQqk0V4yQJc2Y6psC
         MNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777281360; x=1777886160;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YJhp9RjB1CYlks4dixIKSaB1cc2NAImnrh4QNBeenlY=;
        b=TvNAeG2hUjjdJedocelF2KGICwFRWWZDKpj2JOBgwvAuxDYPhQCembgflwAxbk+OMO
         lcbazcJH5UJhE+U5kHeJo80SO+HQHP/udvOvdCmGqlG9hDxJwum6ZnqeKmnKTOeWmSFN
         uaZKD8cGQdpr7C+wSFCu9ZwmfoR1Jvz+RdmMNC/9ANkZ9JdqD5TZczojfCANkZt3KaJg
         1WIfbBUkdwKDt8ckhcirG3W27UJvAuzxk+icGQZP2T70sA7bxeaEU2JKxSj6U1HZFcU0
         t7q3nr8oWH5lsOWCIHs/F861Q3oWDDp9G+uSbbjXqCNfJVOI4KPNMeKzfne64bo4RvCh
         ceGw==
X-Gm-Message-State: AOJu0Yx5ROZcthWzpO7U1kcIkFBneIccasqFR/cKRHKmuR4QUXOv/adZ
	NcvNGTeNNcpqAHA00a+i4zpfOtJhyAJ06rnOjiHSAs5txnRPz1cp7gZzUO+fLRC7NhUWh3Cx5cO
	CXtkYQIrO7P4WtedFb/kpy6KDQc2r/Ip9KeTHHyxVd3+JnKlUGvygmR80X+khBO8=
X-Gm-Gg: AeBDievdyHlLrOqq4b6Pw550bfOX+Fn1Eg3TihHHa2psw4qCJzq8f465dBc20BEfSJU
	dpFOpmkiwJmi/QGDOZUgac+TheIMolRhik2iUtAG0tHvYYxNfc1wrx4MRx5hdZypDvaQxcVzf6E
	rfXY0Ii7M4mTpXw3Rh5oBZCa74TKnvLkJ0T3UTgUWkJHAjiQ824HziRuqTlxiBJCBv5oIwPGi1l
	Nm8dWBSCW5l0zorwGKh+j8isa7Saz42f0r/HcT0q4ooPgczBAEACvrIVSACPmFU4W0xYt+QmDfP
	AVVxxygjeI8x5ni5AsLtY8tmXt1NSwrpqWhWe4e6niCtHAOfSajErKltm3gvhoghHDi8wTM17FB
	ScA7j7qKKjROj+EiSWH4RfUbAO3vYiN84E2SV5imsAfh472xXkYRL7oJZIn4hUQ==
X-Received: by 2002:a05:622a:590f:b0:50f:c2f8:406f with SMTP id d75a77b69052e-50fc2f847cfmr313194381cf.25.1777281360052;
        Mon, 27 Apr 2026 02:16:00 -0700 (PDT)
X-Received: by 2002:a05:622a:590f:b0:50f:c2f8:406f with SMTP id d75a77b69052e-50fc2f847cfmr313193951cf.25.1777281359494;
        Mon, 27 Apr 2026 02:15:59 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:5062:ae86:23aa:702c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a6dbfd4b5sm40559365e9.28.2026.04.27.02.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 02:15:58 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 11:15:35 +0200
Subject: [PATCH v16 02/12] dmaengine: qcom: bam_dma: convert tasklet to a
 BH workqueue
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-qcom-qce-cmd-descr-v16-2-945fd1cafbbc@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4421;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=YERqA6ytYIBXeEnEVHuNkc6pRniKdplpfqUBYqgG5Qg=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBp7yk+0IR02U4vnvTl2IX14Yli5+ns+gg/PlpWP
 b+iE3z2vWOJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCae8pPgAKCRAFnS7L/zaE
 wz9YD/sEVzMrsUIG4UaK+/mt54Mp3VBFDDXVNm2K2U7sk0ppOLMYr4EutporK7oql4DcPrzFBZt
 Qk56jWtdQOpI0X/p2Z1Ppe61eX49zb8F9kDXiI0plagIc3EDjan+8SgKgoVcge0aROw9CUXl4tM
 u7sHqClBoegraSAdRDDiwFQ5BjsObELo79m0DRPET+gPZ8GcTm14Gi/6VjpQ4WK/+Tn8lL/qBGl
 cAIu2CcguniTHKWhoDiSU/PqGfcLYn5Qq9f9SpaEj7ywWy9TjyD0sZn/vfA7uhc1aavq7PloA+b
 5DNrQpskyFl9k5uRr6j4wDGvvEIgwlw5mLCrq4CvOxMdW7INCUJq9yZZ0BPteEW0DP4B2GjdsuZ
 K+AywqtlfyVNrr3H2Bo7OXyC2G91MoaGPl0YB4fODR/fQxbx2X+P2O6/4Z7eVW7saTGruN7MAR2
 paNamOud48+wEY00NhkXCBc13vGO03AuGGfrF2h946eDZn3DsES1wL9znf5CHaCAmPt1hrmSTIT
 LCkgZw3ij2COfvaA4QRIic+ovd9iN36hYLfu86L4C0ipCFJmwck4++uWzad7N65CySvLbRdMb1w
 qbUVfcb2+ovKD0nhbcSwWVHrb7M/21CbmG79mv2EkJOdQT+se+2A8hV8p7v0/2o6jeh6wkt+9p6
 6+wtVqWTC3L6smw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: Opf63kivuzKn90mxlkfAfNRodjlZ-eLy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA5OCBTYWx0ZWRfX6B1qyz7sQVLu
 IMSLXziwnmYh7VZM422Pc9VRLtuvjpVxprbLAp4BhlF2IbzRkYrCp9r7kaCYsVqwfMyFGDroPR5
 q2ZKfAyy/9eP1aPz3hdHcNntf8d4mwBWwyNOuM5G/zG63t7ogwJgam/xxzmQU2bEYnvxFc+JgUt
 rNb6VJiw+mx4C+/nTbxqBKmA/iiFtNFIWjcSM1z1IcTizrnnCMxNlssqvDUYKnkq12lchlazdFJ
 /vC0lrzTllIrVrtNIcwt8+r85wy4SpHlOz5IhHWfbgEr8Qbaw+MroXLqGvl22dPsv9/V4QjR4tK
 I8mDkOt+9dm5SgUJ+razsVX06gTAiwSrPr+qEiDm9hig82zyV0c67AQEP3IlJJdueM8boQ9TShq
 eLJ/4cpoFyRQoyO5EnrNki14bEgHDcqopfdoCUL/q7mkX5UzBz/zATisL72AnLOuy+O/jrlXv8S
 6L9BNribA0HZbPxCWVA==
X-Proofpoint-ORIG-GUID: Opf63kivuzKn90mxlkfAfNRodjlZ-eLy
X-Authority-Analysis: v=2.4 cv=J/GaKgnS c=1 sm=1 tr=0 ts=69ef2951 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=u-biHsxzOdRIXVMzAPsA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270098
X-Rspamd-Queue-Id: E7B9546FC57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10126-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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

BH workqueues are a modern mechanism, aiming to replace legacy tasklets.
Let's convert the BAM DMA driver to using the high-priority variant of
the BH workqueue.

[Vinod: suggested using the BG workqueue instead of the regular one
running in process context]

Suggested-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/dma/qcom/bam_dma.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 19116295f8325767a0d97a7848077885b118241c..c8601bac555edf1bb4384fd39cb3449ec6e86334 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -42,6 +42,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
+#include <linux/workqueue.h>
 
 #include "../dmaengine.h"
 #include "../virt-dma.h"
@@ -397,8 +398,8 @@ struct bam_device {
 	struct clk *bamclk;
 	int irq;
 
-	/* dma start transaction tasklet */
-	struct tasklet_struct task;
+	/* dma start transaction workqueue */
+	struct work_struct work;
 };
 
 /**
@@ -863,7 +864,7 @@ static u32 process_channel_irqs(struct bam_device *bdev)
 			/*
 			 * if complete, process cookie. Otherwise
 			 * push back to front of desc_issued so that
-			 * it gets restarted by the tasklet
+			 * it gets restarted by the work queue.
 			 */
 			if (!async_desc->num_desc) {
 				vchan_cookie_complete(&async_desc->vd);
@@ -893,9 +894,9 @@ static irqreturn_t bam_dma_irq(int irq, void *data)
 
 	srcs |= process_channel_irqs(bdev);
 
-	/* kick off tasklet to start next dma transfer */
+	/* kick off the work queue to start next dma transfer */
 	if (srcs & P_IRQ)
-		tasklet_schedule(&bdev->task);
+		queue_work(system_bh_highpri_wq, &bdev->work);
 
 	ret = pm_runtime_get_sync(bdev->dev);
 	if (ret < 0)
@@ -1091,14 +1092,14 @@ static void bam_start_dma(struct bam_chan *bchan)
 }
 
 /**
- * dma_tasklet - DMA IRQ tasklet
- * @t: tasklet argument (bam controller structure)
+ * bam_dma_work() - DMA interrupt work queue callback
+ * @work: work queue struct embedded in the BAM controller device struct
  *
  * Sets up next DMA operation and then processes all completed transactions
  */
-static void dma_tasklet(struct tasklet_struct *t)
+static void bam_dma_work(struct work_struct *work)
 {
-	struct bam_device *bdev = from_tasklet(bdev, t, task);
+	struct bam_device *bdev = from_work(bdev, work, work);
 	struct bam_chan *bchan;
 	unsigned int i;
 
@@ -1111,14 +1112,13 @@ static void dma_tasklet(struct tasklet_struct *t)
 		if (!list_empty(&bchan->vc.desc_issued) && !IS_BUSY(bchan))
 			bam_start_dma(bchan);
 	}
-
 }
 
 /**
  * bam_issue_pending - starts pending transactions
  * @chan: dma channel
  *
- * Calls tasklet directly which in turn starts any pending transactions
+ * Calls work queue directly which in turn starts any pending transactions
  */
 static void bam_issue_pending(struct dma_chan *chan)
 {
@@ -1286,14 +1286,14 @@ static int bam_dma_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_disable_clk;
 
-	tasklet_setup(&bdev->task, dma_tasklet);
+	INIT_WORK(&bdev->work, bam_dma_work);
 
 	bdev->channels = devm_kcalloc(bdev->dev, bdev->num_channels,
 				sizeof(*bdev->channels), GFP_KERNEL);
 
 	if (!bdev->channels) {
 		ret = -ENOMEM;
-		goto err_tasklet_kill;
+		goto err_workqueue_cancel;
 	}
 
 	/* allocate and initialize channels */
@@ -1358,8 +1358,8 @@ static int bam_dma_probe(struct platform_device *pdev)
 err_bam_channel_exit:
 	for (i = 0; i < bdev->num_channels; i++)
 		tasklet_kill(&bdev->channels[i].vc.task);
-err_tasklet_kill:
-	tasklet_kill(&bdev->task);
+err_workqueue_cancel:
+	cancel_work_sync(&bdev->work);
 err_disable_clk:
 	clk_disable_unprepare(bdev->bamclk);
 
@@ -1393,7 +1393,7 @@ static void bam_dma_remove(struct platform_device *pdev)
 			    bdev->channels[i].fifo_phys);
 	}
 
-	tasklet_kill(&bdev->task);
+	cancel_work_sync(&bdev->work);
 
 	clk_disable_unprepare(bdev->bamclk);
 }

-- 
2.47.3


