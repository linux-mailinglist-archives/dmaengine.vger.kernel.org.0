Return-Path: <dmaengine+bounces-10547-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDvfBohkDGpXggUAu9opvQ
	(envelope-from <dmaengine+bounces-10547-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:24:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 218FA57F90E
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D2D03050C93
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 13:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983A6408107;
	Tue, 19 May 2026 13:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="phvzaA6y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i6rHliRY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0494E3797
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779196718; cv=none; b=LQEd0SZMZTlx36tpSRHXIgd53QefBEgkiTPz4q4WjysjlkcEHYmm3yO2arIkZtGkUX8NPUks82QLenPNnBEi0GZQuRxwTPYrkOJthi/eG/26LEJxvhbE+BoBN4l5KHAJMBiGgRwcvXjJNFO18XDDsaHzvmLu3iWQyih2OPqWITI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779196718; c=relaxed/simple;
	bh=ACfjNn0Xmi0xAz9LfKtOCRm3C6QBMsK1YM4epEGgMH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=govgvD4tEE6kEzl/pjExiLHvvcmgB4Hriv/UM8A9Pf5xnMJGH8wxf52IXhmb/Ud95jZXoUSvBKHA4dIrp47F2OJDDy79JYgx2b4xtK0uqEK4IbjazKx7zln1xfr0592BuvOuYe8UGLa9lbqyh8I84KZoQR2fr8IMArNDueuL64w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=phvzaA6y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i6rHliRY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J7mB4s2975785
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vnYjXg4+G9V3/qfm1Rdkfn1Xa8dIu/5XX3bTDFJWAzs=; b=phvzaA6yv/M7JJ+4
	DtJZkpZRDrCEE7J5bZF9aTtClkuLwyVtqR0IJZHyZDRPfG8rULQwz9Ijvyec4+qv
	VsgrtpU4BUWO9bd04Gro+RI2QHIPEpH/cCUaijwrKSmR4l2pBZpLlZyZRPYZ8ocD
	I8L+PJbUNArCsfpu53CIpuAmm5PM3yPx4lyMEzCHv6j9nWq9Yxs0kfkK3sVzIRvn
	Vm9++8V7XTZwYOPjhTzPoB/qlL2ldYHeydJqpgsL+hhHe1Yb/vdSiSCPrv4WB+Lo
	5Rv4XiDE2gBxImx6XcIkZ7o4Gc2I7kWjfFUOzuseWgQPmFDYhXFk5VNjt5CaK35i
	EjODww==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e84v4cmxq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:18:34 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-56f6ef62af1so9984615e0c.1
        for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 06:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779196714; x=1779801514; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vnYjXg4+G9V3/qfm1Rdkfn1Xa8dIu/5XX3bTDFJWAzs=;
        b=i6rHliRY7f6jJK6mTUoKwmVt7pVGQx1SOa2YaU3FuJhsosoQFt84cfNeuPhTMTpTaE
         erkjbKlJB6plg3vCyhs6//ulGSguFJ23uWTd95TrsR3A5yIRgE0v8nxPpEKB0LowkDt1
         IuHJi9op6ewQGdVRJ1oaw9qM+fBN7+7ihL2Lk9rNyYPJ0dDijLmO7v2+BggN2vFnDiT9
         lN37Yjgc7TR1Vu6hfWGV3QbVDdw40zeSZO8pLri8Hm7+yNxurDDZcmQ+J07+H/qrassD
         jZowObe7cx7E5/ZH7AAfBRAww+Mn5bq/WBqxxNh9+PZwIFagCT4kBYcW4kFx/gtdCIeF
         zB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779196714; x=1779801514;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vnYjXg4+G9V3/qfm1Rdkfn1Xa8dIu/5XX3bTDFJWAzs=;
        b=YHGbtjkAN+wgDIAt5SCAyOE7Y9zmdmLPW30UI4gWp3yLZQDyj0Bj6ETYkbt14I/5uA
         Kaq3XqJ9g4lcsrMv4VIVGIP3py2/oMogfFgixPfx3+pMm24OP0AsUm9OGWCTzUiTJECp
         2VPoZhLIabFVZiUyRl5g3swK6ln+t3ZS2q62qCOP1ZxWfrmRwQud8e8XKpRFjDLCCLFp
         hJ86rtE8KgRGjf6G7sqe2Mk7drkF0AutaeD+/stmOaM8siWPhxg8AZPbm850yC8kDC3R
         UmHSqLG8lGDOoEwUGU886timXd8BHaZHND/EGhe+ebzbnwEsRgh+VvORX1MODTJZDsmQ
         nhHQ==
X-Gm-Message-State: AOJu0YxS2vRIltDYtyuDO+7bEXUlm+2Kv7YffBRfex7ZVRC7Q+ag3DVW
	kfK1uEaZKVhKCZHwnFUvIOrU4lBnkyCMciTIetJHHTxBcRr1bFpiq6qKGqX4wGNp0Al77BXX5Eo
	WE/1QeBYrms9HTWFoZz81V9eQTAlnOMxBXaLwl3KE7un1mgpatZSyRI3DQENOU38=
X-Gm-Gg: Acq92OGHkbDGpRWIT0FNeUalkTuXnHLBIQIH/TYEQY/lE7osSMkBR84sps+GGGSpZZ/
	PPOjIEgRy+ekJb9rnQaClABNBdJoVvw6ZMcRJLMszgdKNm9Dlhcv8vVHeyktG9w8DH2apLGcy2T
	o+tuoeRO0BkAajHEQaxBaWsR4vHhxuieame0SKXbsIi1fbShHvFc14Dani6N4JG6rb9grTImVBR
	FS1xgQo/7jq6mZ3rqCeac1puhj/ukzAmgrHoS3YwUGpn2LK8EaBSbIhgG1uIMhJpD//MNj3s5zo
	iYRHV6UfnV00eI/77P650dWWay2N8xICk2rz38bwiZX84dQXp+6ntwdxOyvtuTLpIISngokkAOk
	fPacy9MtGl2bmA1CvHBtf8RQLSNfcPwQtikbuznmwEVowqNCL06U=
X-Received: by 2002:a05:6122:8482:b0:577:48e1:8aff with SMTP id 71dfb90a1353d-57748e1c34dmr4550035e0c.11.1779196713927;
        Tue, 19 May 2026 06:18:33 -0700 (PDT)
X-Received: by 2002:a05:6122:8482:b0:577:48e1:8aff with SMTP id 71dfb90a1353d-57748e1c34dmr4549992e0c.11.1779196713486;
        Tue, 19 May 2026 06:18:33 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:3fb6:74e3:3c25:ba2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe7dd22sm143969195e9.7.2026.05.19.06.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:18:32 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 19 May 2026 15:17:54 +0200
Subject: [PATCH v17 12/14] crypto: qce - Map crypto memory for DMA
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-qcom-qce-cmd-descr-v17-12-53a595414b79@oss.qualcomm.com>
References: <20260519-qcom-qce-cmd-descr-v17-0-53a595414b79@oss.qualcomm.com>
In-Reply-To: <20260519-qcom-qce-cmd-descr-v17-0-53a595414b79@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3111;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=LwaqCPG1Aiq/Ip1gw5isqE52deYIfhKxJV8LsPZOfRA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDGMMgUZBXtAun1WVICmoDrKlYXgwNP/Vtty4q
 LAYL2RvuMSJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCagxjDAAKCRAFnS7L/zaE
 w+nED/wOXv46s4GX7vrYvm0ZwRQQQ0Y7E6zST/6NIODzhLlnL+vsiagdUCEyu4PFaZckHGoYQKu
 cNyOGysFV8YV6aI2YIpQTQ2M5sJKPtDd2IXy13as45HSwlRSRV+iULi1SnE7ZU3kaiKb2+k0NsT
 iJxx+NokE9zo0+0+VWFFmgO+pkulbP14peCl6UW4uS0+jC5Q5ND6Bhk9PeoTnHIlbY/a5oiIQqx
 KEHwGQmVoANRMbbaxaH9BzgehT9a/f7BV/DPcGvYfrluShfiQcMJ/ub/Ru4g4pyL1mdhbyETYfM
 YoXa2wI7M7zhA9Stvpj3JJ0Yu7ppCvG/Hck0QmfLvWyc7IVrXfMpJvexhzlTKRsNVZR8wbT1dII
 xtqJL22Rb6+qIgqygmyuzZiiS30nm4HEKAgksbwCTPg3gQM49BWymwUwg0PfbYCNlxVCmyPzNHm
 7WCt/CntNKJYpkGrX0oTVnq9wnHfzK2reZRUW9kUzIh52tm1uMfByu9Y7kCelBuxbrbXxEM3av5
 LvXhZLHGLzTHL9x+j7WR4U4kjyuPWig0Z5Jk8j8ydi5x/GupqP6Z4MIhM0fjGshN1hazJjTt1cF
 BAB3MCZQ9RuGBZLVfazkIJ6mtWx/joYdpNcs4LoyFwFqAN5VTiwkPzCs5/odP0Rp5nIRA9twd2e
 LAGPCYT0mvqtFBA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=VJPtWdPX c=1 sm=1 tr=0 ts=6a0c632a cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=KKAkSRfTAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9tNk7rGwWxUH_P3zroIA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 68jAuLxu4y1B_sStNpN6w4PQpBiElPlW
X-Proofpoint-GUID: 68jAuLxu4y1B_sStNpN6w4PQpBiElPlW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEzMSBTYWx0ZWRfX27sL0dej4BXB
 Gc/HG2TlmW1vqdpk1uQQvKIAhSXHlzs/kug7A1MYtFiS8Ii26QklW6mE4GQWZ3/tLYBnsR2oew7
 hQaTE7wuio1zNhUMxQOzu/EmSwti9RibyM3T48PB7eaQlJB4BXlhhHnMfo+sf1t9nGjCOiYmdC0
 rkDh9aCiqg4CxZpd0JsAWxh4xZTvBQ+gaU1OyrtEPcC7iaFtUoQBw5O1zJ4/bcmefCqG3rqZUfg
 5DUBrpfKzQV4UC6l7zgKKponlwIJH6RZvMySkx2z4Gr72wf3/lj3XHdOwN9CmmCsuFbBvm2gg9M
 cub2fDqIaSRAXbbHTwC7ZhVFCZE4BnQ+0fUqxPnASu0BcnmiMDoiAKk3xZeBvBzV3LraZ/QfbUw
 ngTQ4eNiRgCD/ez9xcX5Rwu0TIUpuABKcXlMAFpxwAHQ6FIVBV/YKOkIycZvGK7RZ7anK4xtEeX
 FtgIQIfSmBSIWyKJ/DA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190131
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10547-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,linaro.org:email];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 218FA57F90E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

As the first step in converting the driver to using DMA for register
I/O, let's map the crypto memory range.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/core.c | 23 ++++++++++++++++++++++-
 drivers/crypto/qce/core.h |  6 ++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index 90f44db6606173d8afbd295a6dadea177b7bcd11..92e551f4570c0c69cbbbb709a0752fbc16c307e5 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -192,10 +192,19 @@ static void qce_cancel_work(void *data)
 	cancel_work_sync(work);
 }
 
+static void qce_crypto_unmap_dma(void *data)
+{
+	struct qce_device *qce = data;
+
+	dma_unmap_resource(qce->dev, qce->base_dma, qce->dma_size,
+			   DMA_BIDIRECTIONAL, 0);
+}
+
 static int qce_crypto_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct qce_device *qce;
+	struct resource *res;
 	int ret;
 
 	qce = devm_kzalloc(dev, sizeof(*qce), GFP_KERNEL);
@@ -205,7 +214,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	qce->dev = dev;
 	platform_set_drvdata(pdev, qce);
 
-	qce->base = devm_platform_ioremap_resource(pdev, 0);
+	qce->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(qce->base))
 		return PTR_ERR(qce->base);
 
@@ -256,6 +265,18 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	qce->async_req_enqueue = qce_async_request_enqueue;
 	qce->async_req_done = qce_async_request_done;
 
+	qce->dma_size = resource_size(res);
+	qce->base_dma = dma_map_resource(dev, res->start, qce->dma_size,
+					 DMA_BIDIRECTIONAL, 0);
+	qce->base_phys = res->start;
+	ret = dma_mapping_error(dev, qce->base_dma);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(qce->dev, qce_crypto_unmap_dma, qce);
+	if (ret)
+		return ret;
+
 	return devm_qce_register_algs(qce);
 }
 
diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
index f092ce2d3b04a936a37805c20ac5ba78d8fdd2df..a80e12eac6c87e5321cce16c56a4bf5003474ef0 100644
--- a/drivers/crypto/qce/core.h
+++ b/drivers/crypto/qce/core.h
@@ -27,6 +27,9 @@
  * @dma: pointer to dma data
  * @burst_size: the crypto burst size
  * @pipe_pair_id: which pipe pair id the device using
+ * @base_dma: base DMA address
+ * @base_phys: base physical address
+ * @dma_size: size of memory mapped for DMA
  * @async_req_enqueue: invoked by every algorithm to enqueue a request
  * @async_req_done: invoked by every algorithm to finish its request
  */
@@ -43,6 +46,9 @@ struct qce_device {
 	struct qce_dma_data dma;
 	int burst_size;
 	unsigned int pipe_pair_id;
+	dma_addr_t base_dma;
+	phys_addr_t base_phys;
+	size_t dma_size;
 	int (*async_req_enqueue)(struct qce_device *qce,
 				 struct crypto_async_request *req);
 	void (*async_req_done)(struct qce_device *qce, int ret);

-- 
2.47.3


