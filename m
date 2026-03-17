Return-Path: <dmaengine+bounces-9484-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KA4YB8BfuWmrCgIAu9opvQ
	(envelope-from <dmaengine+bounces-9484-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 15:05:52 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5382AB6C4
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 15:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C3BD30CAD7A
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 14:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FFD3ACA43;
	Tue, 17 Mar 2026 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GGg4yN0e";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hym464lM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30833E1238
	for <dmaengine@vger.kernel.org>; Tue, 17 Mar 2026 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756167; cv=none; b=c3aaVNkmXNqQHhxRjdRaSaPyqNQDj6n6wU0VVUGCGTf+UkjYOKYfokGSx51iZKit5n8vxzS8Az0kf2NuZ3Y94RO0vf+bJkAT1ASEM1Fq7Qc2V4i/4cX/0mTrEga69kxSBHbuKMmdTIOwWya0Xdqy+ik9MIY4Ui+usJm76e5Sp3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756167; c=relaxed/simple;
	bh=YERqA6ytYIBXeEnEVHuNkc6pRniKdplpfqUBYqgG5Qg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mqaBuXKIde1nQ9IPYqHvRl8qtxPWNAc/OZ0+kPZ9Gqzce/4vpE6HahJwRZrZ26MTm1vJvmCOq6KBafy9SUUjPFyHjuUquA0J9ua3g4NMybO0k5D+Y9DzVvsAbgFpO+XGCL5mABwK/itM6+uvu8enJ541kZqZDw39Wffwi4Bh3IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GGg4yN0e; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hym464lM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HAWpKk2671865
	for <dmaengine@vger.kernel.org>; Tue, 17 Mar 2026 14:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YJhp9RjB1CYlks4dixIKSaB1cc2NAImnrh4QNBeenlY=; b=GGg4yN0eygj/0biO
	29VrrpLUm9gihxxqKae7wIMSDGOT/MEq2dTDuGVnQIMilviGHZEY/Xhulqfg+dgX
	jEIqLHZ1FJnKW2QaL8YU422KzoowJWGxcdPsJzu52gG4S7icPxyeVnR3jw3U9ejJ
	dZ12dHOI1oL7GexNZ++Y36G22c6/ruOsBDwhB6NLBZ+MxVtkiP8u4dbcFr6SlhOg
	ZXkZfOi+F1j4PJg63Nb7IFufzFqr1VJwUFBM8jtykFiQiWW9GeK6Cr7KGXHu8cp0
	UxjxEnsYDmpaV177P5cXpNO64RePlH5fZMApIMBGKcvGwtTelb84y+VVDHhFkeOr
	sVgB6w==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxmf2c569-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 17 Mar 2026 14:02:44 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-94ac4a7230dso11316452241.0
        for <dmaengine@vger.kernel.org>; Tue, 17 Mar 2026 07:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773756164; x=1774360964; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJhp9RjB1CYlks4dixIKSaB1cc2NAImnrh4QNBeenlY=;
        b=Hym464lMALiVzGdqSI+/0ze7IcklLl6GRFQzTHIM0S8ZQwmRuunRozAHEZ/6hWM/38
         z87IxNaxFP8lYAMagwd926NPFKYC6ViC6VvzbgPBCz2UWnJaoWEiExjQxIGNL85nzA5o
         k9bLCdOFpb2mcRQnRRyd5/mBzD6DHZkIVrHiT+5tVVR1/Oow1E79fVN2RWpvr/U+vvyU
         HENGUQjkXiDG/2653xO1tHJeZTfs7TgXlPhpbaNTbUACp/UXKO6X3Rvv2pk4Xe5aasd8
         34cBPZshdW9U2oxDUEJZcwXlp5BPgcWBoZPMk6mgwKCIh/eDBQu18gVxC3BDbzNHmZ7z
         PZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773756164; x=1774360964;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YJhp9RjB1CYlks4dixIKSaB1cc2NAImnrh4QNBeenlY=;
        b=RXFCYhpHcHO8WZIkxWa9dyio+92PFZMEaPUCcUMCJiRXfgHVGxb3ozvYtp6cYaBvFs
         spS0XzrNDkHklPnHPH+kVkmhvmv2UOY906HBLaogzXoluq2jwVxTCo42C3CeYM5dJ38x
         fpYGAq31YpL/71yaSshbxo3sQb4oq+h6lhw9+FUXghSvU5apf3FjJ9WyKCokMKINoKsp
         wCsV4iGXktzdchdzdl6kvI0Wu0u70HE9oNnntook3+f0+CT0d7wE0rwzNil7XYm45+nl
         kQv3NX1MNKJrMu4cnOgkNP2LAgGje456rChRj81LSbx1sTtczSeVTFrPqrq4mI74pWfQ
         iGvQ==
X-Gm-Message-State: AOJu0YxijYgD6XlrJS/WCRjmUUJxHnUotWyC5uS1OcZ0uxLjfXxF1PC5
	XrPvC/ErMKBZh2vmHR98u5fBNZ/lTChn5+26fPQOdRP/QRaag6hyd4ZUGcYZj2tmDxXCRyfW39E
	eEabBf1eVIM9EJf1ODnGx5Aka2TyznHKfUnaaJJ8wibm2JK12V/8ym5ANSHl00Pk=
X-Gm-Gg: ATEYQzwdPizH8lZX4d8EXm2CAhQnVQf/IdY+QnQRIMSIl8EpY8SeufJuJcMfL9r3gTY
	U+rQ+Wsu1muuf1gHtxl0n7t580UmCLMSQ7Hom6AtafkwmQUxyDPz7F3cnB6vGZ9SsE9hXVVfmlX
	mzpAsjoCS/JaZxK9f+CjuZocKnxM3065+eu/KgktzTfiAhgZNEyZaWbWB0KG+/A71OYXUkx+L1h
	1JEvmeq5Y7vDlqIeX7g6ESuR7s3W7IQz5AYUW03sbp4dMhUog8Cczsy2zvBhH6hY+zhQStYmvu+
	lDpYNELThzOKvCp57tQ8x0ALunz0MyuvE07O3W0uiPoaT5hhV1pq0RSSfb446ebKzUbOp2vZigR
	TTzjHzFjjjqde/t1BseuzXrWZNQ0k/r+IxOHPNPdeAMgVzieNz4Od
X-Received: by 2002:a05:6102:c53:b0:5f8:e2c7:a3f2 with SMTP id ada2fe7eead31-6020ddf66c5mr6210958137.0.1773756163806;
        Tue, 17 Mar 2026 07:02:43 -0700 (PDT)
X-Received: by 2002:a05:6102:c53:b0:5f8:e2c7:a3f2 with SMTP id ada2fe7eead31-6020ddf66c5mr6210873137.0.1773756163124;
        Tue, 17 Mar 2026 07:02:43 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:6aa2:dd35:4d6d:8eec])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b4938854csm9359709f8f.34.2026.03.17.07.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 07:02:42 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 15:02:09 +0100
Subject: [PATCH v13 02/12] dmaengine: qcom: bam_dma: convert tasklet to a
 BH workqueue
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-qcom-qce-cmd-descr-v13-2-0968eb4f8c40@oss.qualcomm.com>
References: <20260317-qcom-qce-cmd-descr-v13-0-0968eb4f8c40@oss.qualcomm.com>
In-Reply-To: <20260317-qcom-qce-cmd-descr-v13-0-0968eb4f8c40@oss.qualcomm.com>
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
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpuV7xt+LlRYHrokXeVDSyCM0tjcBQD8bv6/GOd
 olQFJHXG9uJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCable8QAKCRAFnS7L/zaE
 w8MpEACPTAhsCkekQZHg1QpPSF0Hp6XgqVqtwzWYMjkwMgysyX43m7vp/u6PrcV9OFyBo6txlgi
 4/jak2/RK0SPZpwkXbToZyeeMtV7RdlVXCTjbkJRG2coAdboA5DakhVJcZd5j5/06b+FfemLa8u
 vZzbzfGYbAxI1ULsMjDUG5BJ97hajXklbtiC2G4llLEHYJCZcfZ0ytbV0RcRW5fZtTCAmb8Jd3e
 ONOqzTmaquqFo3EwHAxqnh/AXKjMDpLxvB5VOUnL+++Z2VXX1PHJWHwomMnPms/Cpuoz+gCcWcq
 FbwlSzeJaHlrzkofIM+56/gKjJV6zmxS2oLvodUfKctU2SAThffXQ774wopaEG/K7MoPh78G3Ox
 /C89Ic+WLXBg0Vtw+E7KINkmagpERTuVAumxjyS0tz0ZJbRhTWX7x1WJGmmpiRlAcHARQlQfR1U
 uPSI1yrHAS8U4tSqO1+3X/dkddeS51EXN/QxwjDBdaxpwKZUjn8KzRB3ERdW/xJRToUgkAe7k8B
 8kQveXFx248wHSauR4R/2+8erguPWup5Qbk2/61GghdQrjI2LvMIN6rsm1w5oYxHb02rQynKInI
 O65uZni/ha25rrWUV8Xau5ibECKPoepozLIYWXxFZrFBELW+yg8mKfIlA86eGpN/Oct7p6AyvXK
 lzhBXUmnnNyJ75A==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: CESsyCA-Uqxm0uBBNLKgGt9KmEp6RJLZ
X-Proofpoint-GUID: CESsyCA-Uqxm0uBBNLKgGt9KmEp6RJLZ
X-Authority-Analysis: v=2.4 cv=FvcIPmrq c=1 sm=1 tr=0 ts=69b95f04 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=u-biHsxzOdRIXVMzAPsA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEyNCBTYWx0ZWRfX7tvQpL3Nk/GZ
 O6Vy5W3I0Gbau3zfHhm+SQXr01Q98af/gDjuq1t6/260xdN352C3OpnKLkYQu21dlgIA0AVYdRU
 Ve1F0vP/cGxbVw0NaRLxqiGylY2Ehm9QKlqVpDkGjcXeFZEzQuDGnDrmwEx4M2gVch0VKoIE1I7
 H/mIQaIbFePp9zeQcF7JHWX/hs8cby8SA09w3no7aWyA4Kkuyx0+PeYb2Rq2R2PovC6yFNh9vgw
 OihAI8ee5iaQLuGaerghIcOeXEk0QKZ9DwDIKdrln5vshhw/PLPbCMvtIXBqR0ZQ5x54dfVyhvM
 4juMXMXF4iVRKYQxyPTGiIR4Z8Zr+TC/xdjf1hdHv5wHuUJAki7IAN8RCiJRQ0S+4AbiFbr28gU
 wyYHitM1+QxyRjZa4oi/6aDbzpTk9G8LBqskywiaQJ/++Xgf0uYmrpDwxh2RBx5GY9LaMmS4wDO
 HEA9gT/PUVTYDDIE4Uw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170124
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9484-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[qualcomm.com:query timed out,linaro.org:query timed out,oss.qualcomm.com:query timed out];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[linaro.org:query timed out,qualcomm.com:query timed out,oss.qualcomm.com:query timed out];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RBL_SEM_IPV6_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:query timed out];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AE5382AB6C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


