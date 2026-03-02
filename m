Return-Path: <dmaengine+bounces-9181-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGYKAoC4pWmDFQAAu9opvQ
	(envelope-from <dmaengine+bounces-9181-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 17:19:12 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF661DC9E1
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 17:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F0F630B6B0B
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 16:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A943426D1D;
	Mon,  2 Mar 2026 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ATTOZmLi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bgx0WFxe"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409EB42668C
	for <dmaengine@vger.kernel.org>; Mon,  2 Mar 2026 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772467073; cv=none; b=MKnlfkpN6MqBfpFRWV+H//gsEa9OfdDHpDckjHtPtgXQu3ZUicjeBr9/m5gHWlFkiD2FKNg36bSLhmnpHOkcqyuavBCphVaPA3P2webslt/5XT26IM300GnvCGQIf8toDcVxf8Axjwi6GFKiZxhRwgecyMVLcNjylV3S31WdJoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772467073; c=relaxed/simple;
	bh=IpyCcQVX9q9Bh7P2C71ZivsP1o69+7Z885fDtTkZvoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QBxgkb2LAiQAFf3EfOGlYqioRmeAE1CEXuXzn8I0w0vPDfyK+wBUgYn6SLdUz5IS6CkGXgoF3NASuYjV0E+IqNFX5e6G3dYx/8//0XEAdanXsYg81mzevSdfvtlqG/Fl2h5PyAo2OCVcYuKcyriXtsQfMCbR7SMqfinrm6SJVUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ATTOZmLi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bgx0WFxe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622EnlCq3223818
	for <dmaengine@vger.kernel.org>; Mon, 2 Mar 2026 15:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2/urxcQjHbvUQXWmg2wCVncg8OrfyW3z29xPxxSUMIY=; b=ATTOZmLiQT1GO5SH
	cZB4CrhY+q+qpHbkF0zF7nX1VZZcNpKl5pidNrRiGqs3xa4/mA4H4lQsmfrYqr78
	j2x4srbdQC9mUTWUP9lIjsnAHicU2ACSRCCqnhejBaoGkHxnafZ13F7fjcC8VJ2L
	nVASTDuvWshgv7+c/JFQDRNUlU4csK4ix/0miN+CBeYFibRT1BILlwbJU/tzu98z
	Ry3DfXoL7ngCcOGxbhHCguiLSb2VylJ48MtJlQM0x2KWyhUnqGIMTKKbzDXvcEN9
	oROrX1aVhNw1gWAGkgVCWiHM40ckXkd7zinVStnVsyaMJWX938NM8m0aeBG7o+Cb
	8HPn6Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn0b1jufh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 02 Mar 2026 15:57:50 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb4817f3c8so3080215085a.3
        for <dmaengine@vger.kernel.org>; Mon, 02 Mar 2026 07:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772467069; x=1773071869; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/urxcQjHbvUQXWmg2wCVncg8OrfyW3z29xPxxSUMIY=;
        b=Bgx0WFxefjNCqi7hDeZxVJDj/XHO8jDopZ6kTTTCQbz+FomH90gqcsZ0/wrszZJIDF
         iGD8nGd1Cx7H9+Q5w5pAOAl7QNveCJCWZQ0Q5DObMCgqsn0gMOEJusfwQpxI9vQbhAxs
         N8emIhkKF0cdnPCgnXw/rONm0ZXbLi6aKVkgkpnRkRZN5b1Wn1LAyxyLG2FA6duGj58A
         1gEtodO3Tp3kEuzph68aNj2zl5QQdZX/jPUG8HIvW9Urx0fvn6FiEtJh35BLcW9MfYat
         7M7nlWpe4EENkanme4zmHo/bVfMeL+zjAUMFqbvnJGq2o9iGjMXBMY6h45Vz5Tr+mJ6S
         5M0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772467069; x=1773071869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2/urxcQjHbvUQXWmg2wCVncg8OrfyW3z29xPxxSUMIY=;
        b=le+ckKQItZ4cKWQyG75lracl4UMmMcak521RNiQrqXZ/LgTe+bAHw95ul/eMsgl/7v
         thy24DbCIBQ+CuK97dOoW3/wumXuJqyawk6Od1Bjh/TzCQKow4rgn0nHjs9YE8PLhlE7
         Egjgfv43c2TUrZZTMdME+DRga39dlnk5fyIQgmjNIjSnYWIs51N/tp35qc2tXi2wBOex
         hr71vnaPO5X1jjg17aWmaQGFHqt2C/mFfBKV0miz0uNBx786ZmdkA9NcQ4cqQtCKFGWq
         CDhj6lZ6PH/w6j7fpSwmTDRIAZRkPK29wg/aXDxRfxCdO0bcZ1KxxVk0k9G+iG50R+lk
         LmNA==
X-Gm-Message-State: AOJu0YxAVFqTD65xBdZi1ZaHyUQzkNuu5REmgfpHtm8jz/J7bQJvRjak
	jCYKIyJXhQWTYTYBITCq5G4cjz17hsphFIpkDs+TW7ODJuDv6uu8OHFJRCAURMMoPOaIjoIPoi8
	p1yWIasDaw1j8vjA3HmJkU2mEZ9Ix5y8QKjz7tpmaZIqcNiAD3JMZpkd3X06wq3+YIfk8XCw=
X-Gm-Gg: ATEYQzxX/ceFs7DjKpAPCShbU3bZ2FgLsJO8UJJYxFnWpmvh1u5qV/1v7Bo3R7CyPBW
	xuzvnAfkRKxtkfJW29Xo73u/Q+t+w77tCh8irQbZqKGcc9d286vVMDD7C9Hwn8ReNU1u0CL/mWj
	VEF8P54+sZiYKiEga/GwXPvgy96+BXG5SYV+cy8GSEP5Ns28MjWRG4OgXxjcEHCGyMkGZ/PurDw
	ErykiuFOKhj7UgTX3louHWYpLykMWPvez7WH5qiaINbylQOKrzMtHn5qZnV327J/uGn3cA6TBRN
	NFWBDZrhNY8GYHIb3C5zotM8rTvX8jQzyKmhOMawGOU4JDrjnENEVRCv+AvsBebPkTmGk8/ixV7
	C+ZTOknz9/e8/DTerqzT2gAhQZ00Lobw5OvSM0Zk0PDQz3s9SX1Rz
X-Received: by 2002:a05:620a:414e:b0:8c3:7f27:a65d with SMTP id af79cd13be357-8cbc8d9d9b9mr1676275885a.28.1772467068696;
        Mon, 02 Mar 2026 07:57:48 -0800 (PST)
X-Received: by 2002:a05:620a:414e:b0:8c3:7f27:a65d with SMTP id af79cd13be357-8cbc8d9d9b9mr1676272485a.28.1772467068111;
        Mon, 02 Mar 2026 07:57:48 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:87af:7e67:1864:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b41831easm11282438f8f.12.2026.03.02.07.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:57:47 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 02 Mar 2026 16:57:19 +0100
Subject: [PATCH RFC v11 06/12] crypto: qce - Add BAM DMA support for crypto
 register I/O
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-qcom-qce-cmd-descr-v11-6-4bf1f5db4802@oss.qualcomm.com>
References: <20260302-qcom-qce-cmd-descr-v11-0-4bf1f5db4802@oss.qualcomm.com>
In-Reply-To: <20260302-qcom-qce-cmd-descr-v11-0-4bf1f5db4802@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Tiwari <quic_utiwari@quicinc.com>,
        Daniel Perez-Zoghbi <dperezzo@quicinc.com>,
        Md Sadre Alam <mdalam@qti.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        brgl@kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10084;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=xVyXRxFp3hoaIPdmV5W3HruIHEbBK3c+oEfKaj3P3iI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBppbNp3uL1qF09VByovmCxr0BrPF2qt0vumz3w9
 4VDWOB+XZGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaaWzaQAKCRAFnS7L/zaE
 w3QWEACVBpmfAzAr7VheSYyio4m2cLxyZN0JpZvXOWcCmYcyKruO1ubprk1VjaXrtxmnqPkJFOA
 8Z2G2q0RWqM3m4FtgyR2cXgBh3H8mWh1N7HNbYfe4DXsL2HBwznabEZPjB5lcQNISfLls/a0paU
 Z5yygOOtjS2O75Z0Y3xqbKacBqbxCkRd5vlQSV9hdQlebDClRP5wZT32tytJzGrXUMK7dtd/eqh
 lHTjxyF9KIAWBLKBa7PPTFW9XMRdnU/BGS3hwN9G77cZ7vh0TIFV6LbwMpUaIIA3aHaltAO2TSp
 ufaNp4It7NI71cUM7S3bZgLYHnUvqKUBjNkiLCaeykIbiJflZ8IIACcnZ2xVRdVHo2Jv9sgB3kb
 UnsqQTh2RC3Pb1/RmrwaJegHk/XCTVNVoVm+zVkbsWCd4IWJx/MZ3M+uh95STXoNAPaCX0eoysP
 IhMrn8HlnXNt5MtoBfwCHpiwbrfmioXT/6pCCPdcu06zPkCcz2xl1ytMoQJZrJ9Zk8FGEevT6r/
 TX1mw84tUvo+l/0Iy+Zx3oCzB/k5mPIfR+Eo88IZ0svKagnxXDauKwFSabFLc+jKx1UCBo+QKNP
 p7qCAu6MWoIZykAmINl/yY6tYNJzo3aUXg/mO5EVEwsIne9FhKDH3RryvT7/Xbd30U41QLqIXwm
 yOcuYuvxgovT7pA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: RJ5HJdoSqkIewumJTu9cCKw4C6B3Ra_y
X-Authority-Analysis: v=2.4 cv=Hol72kTS c=1 sm=1 tr=0 ts=69a5b37e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=koLDk85rXkRIAoTU0vQA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: RJ5HJdoSqkIewumJTu9cCKw4C6B3Ra_y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEzMyBTYWx0ZWRfX7U9yvPeWzMMr
 fJHV5lGyfIpBXZwiVzLZe1yJkg+KL3lnRie9k3cqP0/VJUOQkuu6vK5zb9mpYzH8jdgSMhfcC9s
 zlRDLvjkPEwkDvNlkKwRlyc7Hp0M7+47+Hprbs02Z6+jfOKqBIlav/Xr4F672TN5q1eI3VblfoD
 IX2ivdzZFnWdLgCuewgk5fi5+06FTqOwCFoSKZLce4tLSv0bcHf06hnltwIglh3nSpBaiLS0/A8
 yv8Tp54q4J1wqS1IlqJDTnSpqO5+HdOf+aMRwqTpYR960MovmqvxOT3GHM8tK2Pcu1YcpinSjn0
 5+Iv8Tg7eDgEVP4DzsmdQnl4BEEa9Hiuxi0KcvYyiSIXhpvFzAlzCtWoao2GNqHyTrO4UjGmKsf
 mld3EJSbJfcbflBBnnvBjhdrH7nD3d4ylVgw88P8rhnmq/Yfm/Wun4W1oI56NDM8JEkOi3Klyx3
 o0e2kjUyEvzwdvpbIYA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020133
X-Rspamd-Queue-Id: 3BF661DC9E1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9181-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linaro.org:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Implement the infrastructure for performing register I/O over BAM DMA,
not CPU.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/aead.c     |   2 -
 drivers/crypto/qce/common.c   |  20 ++++----
 drivers/crypto/qce/core.h     |   4 ++
 drivers/crypto/qce/dma.c      | 109 ++++++++++++++++++++++++++++++++++++++++++
 drivers/crypto/qce/dma.h      |   5 ++
 drivers/crypto/qce/sha.c      |   2 -
 drivers/crypto/qce/skcipher.c |   2 -
 7 files changed, 127 insertions(+), 17 deletions(-)

diff --git a/drivers/crypto/qce/aead.c b/drivers/crypto/qce/aead.c
index abb438d2f8888d313d134161fda97dcc9d82d6d9..a4e8158803eb59cd0d40076674d0059bb94759ce 100644
--- a/drivers/crypto/qce/aead.c
+++ b/drivers/crypto/qce/aead.c
@@ -473,8 +473,6 @@ qce_aead_async_req_handle(struct crypto_async_request *async_req)
 	if (ret)
 		goto error_unmap_src;
 
-	qce_dma_issue_pending(&qce->dma);
-
 	ret = qce_start(async_req, tmpl->crypto_alg_type);
 	if (ret)
 		goto error_terminate;
diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
index 04253a8d33409a2a51db527435d09ae85a7880af..b2b0e751a06517ac06e7a468599bd18666210e0c 100644
--- a/drivers/crypto/qce/common.c
+++ b/drivers/crypto/qce/common.c
@@ -25,7 +25,7 @@ static inline u32 qce_read(struct qce_device *qce, u32 offset)
 
 static inline void qce_write(struct qce_device *qce, u32 offset, u32 val)
 {
-	writel(val, qce->base + offset);
+	qce_write_dma(qce, offset, val);
 }
 
 static inline void qce_write_array(struct qce_device *qce, u32 offset,
@@ -82,6 +82,8 @@ static void qce_setup_config(struct qce_device *qce)
 {
 	u32 config;
 
+	qce_clear_bam_transaction(qce);
+
 	/* get big endianness */
 	config = qce_config_reg(qce, 0);
 
@@ -90,12 +92,14 @@ static void qce_setup_config(struct qce_device *qce)
 	qce_write(qce, REG_CONFIG, config);
 }
 
-static inline void qce_crypto_go(struct qce_device *qce, bool result_dump)
+static inline int qce_crypto_go(struct qce_device *qce, bool result_dump)
 {
 	if (result_dump)
 		qce_write(qce, REG_GOPROC, BIT(GO_SHIFT) | BIT(RESULTS_DUMP_SHIFT));
 	else
 		qce_write(qce, REG_GOPROC, BIT(GO_SHIFT));
+
+	return qce_submit_cmd_desc(qce);
 }
 
 #if defined(CONFIG_CRYPTO_DEV_QCE_SHA) || defined(CONFIG_CRYPTO_DEV_QCE_AEAD)
@@ -223,9 +227,7 @@ static int qce_setup_regs_ahash(struct crypto_async_request *async_req)
 	config = qce_config_reg(qce, 1);
 	qce_write(qce, REG_CONFIG, config);
 
-	qce_crypto_go(qce, true);
-
-	return 0;
+	return qce_crypto_go(qce, true);
 }
 #endif
 
@@ -386,9 +388,7 @@ static int qce_setup_regs_skcipher(struct crypto_async_request *async_req)
 	config = qce_config_reg(qce, 1);
 	qce_write(qce, REG_CONFIG, config);
 
-	qce_crypto_go(qce, true);
-
-	return 0;
+	return qce_crypto_go(qce, true);
 }
 #endif
 
@@ -535,9 +535,7 @@ static int qce_setup_regs_aead(struct crypto_async_request *async_req)
 	qce_write(qce, REG_CONFIG, config);
 
 	/* Start the process */
-	qce_crypto_go(qce, !IS_CCM(flags));
-
-	return 0;
+	return qce_crypto_go(qce, !IS_CCM(flags));
 }
 #endif
 
diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
index a80e12eac6c87e5321cce16c56a4bf5003474ef0..d238097f834e4605f3825f23d0316d4196439116 100644
--- a/drivers/crypto/qce/core.h
+++ b/drivers/crypto/qce/core.h
@@ -30,6 +30,8 @@
  * @base_dma: base DMA address
  * @base_phys: base physical address
  * @dma_size: size of memory mapped for DMA
+ * @read_buf: Buffer for DMA to write back to
+ * @read_buf_dma: Mapped address of the read buffer
  * @async_req_enqueue: invoked by every algorithm to enqueue a request
  * @async_req_done: invoked by every algorithm to finish its request
  */
@@ -49,6 +51,8 @@ struct qce_device {
 	dma_addr_t base_dma;
 	phys_addr_t base_phys;
 	size_t dma_size;
+	__le32 *read_buf;
+	dma_addr_t read_buf_dma;
 	int (*async_req_enqueue)(struct qce_device *qce,
 				 struct crypto_async_request *req);
 	void (*async_req_done)(struct qce_device *qce, int ret);
diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index a46264735bb895b6199969e83391383ccbbacc5f..ba7a52fd4c6349d59c075c346f75741defeb6034 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -4,6 +4,8 @@
  */
 
 #include <linux/device.h>
+#include <linux/dma/qcom_bam_dma.h>
+#include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <crypto/scatterwalk.h>
 
@@ -11,6 +13,98 @@
 #include "dma.h"
 
 #define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
+#define QCE_BAM_CMD_SGL_SIZE		128
+#define QCE_BAM_CMD_ELEMENT_SIZE	128
+#define QCE_MAX_REG_READ		8
+
+struct qce_desc_info {
+	struct dma_async_tx_descriptor *dma_desc;
+	enum dma_data_direction dir;
+};
+
+struct qce_bam_transaction {
+	struct bam_cmd_element bam_ce[QCE_BAM_CMD_ELEMENT_SIZE];
+	struct scatterlist wr_sgl[QCE_BAM_CMD_SGL_SIZE];
+	struct qce_desc_info *desc;
+	u32 bam_ce_idx;
+	u32 pre_bam_ce_idx;
+	u32 wr_sgl_cnt;
+};
+
+void qce_clear_bam_transaction(struct qce_device *qce)
+{
+	struct qce_bam_transaction *bam_txn = qce->dma.bam_txn;
+
+	bam_txn->bam_ce_idx = 0;
+	bam_txn->wr_sgl_cnt = 0;
+	bam_txn->bam_ce_idx = 0;
+	bam_txn->pre_bam_ce_idx = 0;
+}
+
+int qce_submit_cmd_desc(struct qce_device *qce)
+{
+	struct qce_desc_info *qce_desc = qce->dma.bam_txn->desc;
+	struct qce_bam_transaction *bam_txn = qce->dma.bam_txn;
+	struct dma_async_tx_descriptor *dma_desc;
+	struct dma_chan *chan = qce->dma.rxchan;
+	unsigned long attrs = DMA_PREP_CMD;
+	dma_cookie_t cookie;
+	unsigned int mapped;
+	int ret;
+
+	mapped = dma_map_sg_attrs(qce->dev, bam_txn->wr_sgl, bam_txn->wr_sgl_cnt,
+				  DMA_TO_DEVICE, attrs);
+	if (!mapped)
+		return -ENOMEM;
+
+	dma_desc = dmaengine_prep_slave_sg(chan, bam_txn->wr_sgl, bam_txn->wr_sgl_cnt,
+					   DMA_MEM_TO_DEV, attrs);
+	if (!dma_desc) {
+		dma_unmap_sg(qce->dev, bam_txn->wr_sgl, bam_txn->wr_sgl_cnt, DMA_TO_DEVICE);
+		return -ENOMEM;
+	}
+
+	qce_desc->dma_desc = dma_desc;
+	cookie = dmaengine_submit(qce_desc->dma_desc);
+
+	ret = dma_submit_error(cookie);
+	if (ret)
+		return ret;
+
+	qce_dma_issue_pending(&qce->dma);
+
+	return 0;
+}
+
+static void qce_prep_dma_cmd_desc(struct qce_device *qce, struct qce_dma_data *dma,
+				  unsigned int addr, void *buf)
+{
+	struct qce_bam_transaction *bam_txn = dma->bam_txn;
+	struct bam_cmd_element *bam_ce_buf;
+	int bam_ce_size, cnt, idx;
+
+	idx = bam_txn->bam_ce_idx;
+	bam_ce_buf = &bam_txn->bam_ce[idx];
+	bam_prep_ce_le32(bam_ce_buf, addr, BAM_WRITE_COMMAND, *((__le32 *)buf));
+
+	bam_ce_buf = &bam_txn->bam_ce[bam_txn->pre_bam_ce_idx];
+	bam_txn->bam_ce_idx++;
+	bam_ce_size = (bam_txn->bam_ce_idx - bam_txn->pre_bam_ce_idx) * sizeof(*bam_ce_buf);
+
+	cnt = bam_txn->wr_sgl_cnt;
+
+	sg_set_buf(&bam_txn->wr_sgl[cnt], bam_ce_buf, bam_ce_size);
+
+	++bam_txn->wr_sgl_cnt;
+	bam_txn->pre_bam_ce_idx = bam_txn->bam_ce_idx;
+}
+
+void qce_write_dma(struct qce_device *qce, unsigned int offset, u32 val)
+{
+	unsigned int reg_addr = ((unsigned int)(qce->base_phys) + offset);
+
+	qce_prep_dma_cmd_desc(qce, &qce->dma, reg_addr, &val);
+}
 
 int devm_qce_dma_request(struct qce_device *qce)
 {
@@ -31,6 +125,21 @@ int devm_qce_dma_request(struct qce_device *qce)
 	if (!dma->result_buf)
 		return -ENOMEM;
 
+	dma->bam_txn = devm_kzalloc(dev, sizeof(*dma->bam_txn), GFP_KERNEL);
+	if (!dma->bam_txn)
+		return -ENOMEM;
+
+	dma->bam_txn->desc = devm_kzalloc(dev, sizeof(*dma->bam_txn->desc), GFP_KERNEL);
+	if (!dma->bam_txn->desc)
+		return -ENOMEM;
+
+	sg_init_table(dma->bam_txn->wr_sgl, QCE_BAM_CMD_SGL_SIZE);
+
+	qce->read_buf = dmam_alloc_coherent(qce->dev, QCE_MAX_REG_READ * sizeof(*qce->read_buf),
+					    &qce->read_buf_dma, GFP_KERNEL);
+	if (!qce->read_buf)
+		return -ENOMEM;
+
 	return 0;
 }
 
diff --git a/drivers/crypto/qce/dma.h b/drivers/crypto/qce/dma.h
index 483789d9fa98e79d1283de8297bf2fc2a773f3a7..f05dfa9e6b25bd60e32f45079a8bc7e6a4cf81f9 100644
--- a/drivers/crypto/qce/dma.h
+++ b/drivers/crypto/qce/dma.h
@@ -8,6 +8,7 @@
 
 #include <linux/dmaengine.h>
 
+struct qce_bam_transaction;
 struct qce_device;
 
 /* maximum data transfer block size between BAM and CE */
@@ -32,6 +33,7 @@ struct qce_dma_data {
 	struct dma_chan *txchan;
 	struct dma_chan *rxchan;
 	struct qce_result_dump *result_buf;
+	struct qce_bam_transaction *bam_txn;
 };
 
 int devm_qce_dma_request(struct qce_device *qce);
@@ -43,5 +45,8 @@ int qce_dma_terminate_all(struct qce_dma_data *dma);
 struct scatterlist *
 qce_sgtable_add(struct sg_table *sgt, struct scatterlist *sg_add,
 		unsigned int max_len);
+void qce_write_dma(struct qce_device *qce, unsigned int offset, u32 val);
+int qce_submit_cmd_desc(struct qce_device *qce);
+void qce_clear_bam_transaction(struct qce_device *qce);
 
 #endif /* _DMA_H_ */
diff --git a/drivers/crypto/qce/sha.c b/drivers/crypto/qce/sha.c
index d7b6d042fb44f4856a6b4f9c901376dd7531454d..9552a74bf191def412fc32f3859356e569e5d400 100644
--- a/drivers/crypto/qce/sha.c
+++ b/drivers/crypto/qce/sha.c
@@ -113,8 +113,6 @@ static int qce_ahash_async_req_handle(struct crypto_async_request *async_req)
 	if (ret)
 		goto error_unmap_dst;
 
-	qce_dma_issue_pending(&qce->dma);
-
 	ret = qce_start(async_req, tmpl->crypto_alg_type);
 	if (ret)
 		goto error_terminate;
diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index 872b65318233ed21e3559853f6bbdad030a1b81f..e80452c19b03496faaee38d4ac792289f560d082 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -147,8 +147,6 @@ qce_skcipher_async_req_handle(struct crypto_async_request *async_req)
 	if (ret)
 		goto error_unmap_src;
 
-	qce_dma_issue_pending(&qce->dma);
-
 	ret = qce_start(async_req, tmpl->crypto_alg_type);
 	if (ret)
 		goto error_terminate;

-- 
2.47.3


