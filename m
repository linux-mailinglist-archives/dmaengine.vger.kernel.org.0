Return-Path: <dmaengine+bounces-10545-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sG0jCt9jDGpXggUAu9opvQ
	(envelope-from <dmaengine+bounces-10545-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:21:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 349AB57F80E
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97126304BA62
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 13:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7B94028EF;
	Tue, 19 May 2026 13:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BjcZyfX9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LyzOg95c"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D53D4EA379
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779196713; cv=none; b=HtLEl0mTkUNdsinfBt9yE9+LLigUpw9LGpU5QV9cSd79Oy0QjA2Wwv9xDtiJXzTS++pWx5wcTsW4sNvOR9KWO672lGYpydsjnlBaX2f5ev1TX7SNNkE1nDuONNLfPBh2MtOdNfFUg5Bcxnu8sxe42qS2fz9ffxoAlGVdNHBsOuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779196713; c=relaxed/simple;
	bh=Q2skbuYcneIldj1tp/vKCnWZqrb/wZJoRKDIAdO7kR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VB2c9CtZwh/hLE5Fjxpn+X7LmG0Ei9DiS7ZQmWVVPTbgMQbOf2JqfpVG7AII5xkMBQF5YWRsyQZUTDCTfxd6bmM1raMLpJtFpYxnlOOfRA3L0TumRzcP7AA6d3tLAjc/fkTIw/eh1tRH/AbZ0k18GnxtkRTH9Es09NSZszKyECM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BjcZyfX9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LyzOg95c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JA8JJc4130457
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	moLln03VVvMKZIRmek9qRzT0EwTuwdZZIig7cvQ2zRU=; b=BjcZyfX9OW56lcFk
	qr3AoW5Sg2qj/bTx6Y7WBYJZTEKZ0S+l0XrnmIx0ry5I40GhxLQ64vIB/Scl1xtX
	TZqody7SAcqVe4iMnoN8xAiER2jb1TA715Sj3kGiEd9unBZ4qj+Gf3Vwwi96oFwS
	S98k3GKmxxgbNRQV1LhF2nOZFo2y6UcTcv4JwBMVQXnNvFuvD+FRJBg7GnVyDbTf
	Juxu5Q12v/CCo/EEf3aFORcmKVvbFepslulH9FaYDfdzVub7vgVYlAttR0aJCiaj
	BGTZAd8P0N52D9hrS+yLAf9TSmr60PHhK0qPpngHekJ3PXKNHf65IqI45fHs+5BW
	EFAJfA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8ht1hw3r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:18:30 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5756024c77eso7900999e0c.2
        for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 06:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779196709; x=1779801509; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=moLln03VVvMKZIRmek9qRzT0EwTuwdZZIig7cvQ2zRU=;
        b=LyzOg95cdAOTAXPLmHoxW4n4nijL5iTa+mtdJYcxhSSMByaaxnTkxOjk/O/VlmMRay
         FR7lnlxxw4xYg6M9qKT25amOdYcxq6fNFVS3SqnHRPiAqB3Z8UIRmI95tVoLZo8jI9mc
         lgQIUqgS4PCHgyqULdvuwxjyfIGeKnpY9seoa71wcgTLXNf6nhOfz1TDhJUw79F5V3Ph
         LDaSx0UX9Oo1Pl6jw/q2Xy9GMEM3Bnv2plr+boTZangxOWydwPKOTlb/u6dUD+C8wSQV
         tZ6tdAYipHdw8Qwj12ce5WpE6pwBzLqGo9HVDfIYS7Pp1ebSvlRB6Tda/4b7NPctF0hv
         pbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779196709; x=1779801509;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=moLln03VVvMKZIRmek9qRzT0EwTuwdZZIig7cvQ2zRU=;
        b=OGYrCD3leKZEe1MuUzhe4N7QkMmoRQDuBFVdQkiP0sjnH9zt4iJ0oGLM7NUqeBDn4o
         G3NqRv99ELyW+BN6TTASFO568Qq8/vSN4RC6fbZ5DvBj/GG6Q7XdsYMhWd1a7Igs9rYH
         psJabU/1/BnJkh+guMedKfbeVXAjMC2p2PTRkjBHigv1T7OwYAzcV/Ft8eJaOGDhRHse
         u/vJ7y7Mi0/3ESZUhyCpimGhLCXFaUCeTrbWss7I2POW/qOBKnd8ztKeiYMLuwMBHqb5
         fnmgcLxKE7a1LjsWXA46AI7oqA4vpWl+ewvNz34GN1q8IriypVySGNwzn6XLyx+uxlKW
         SOnQ==
X-Gm-Message-State: AOJu0YynUOsQ6go1Nov3cNRczbiKmeWD/78I317CYaYAlE8Y63KLwz8Y
	I00VN4kHZYLcTtOR+szWheytn3/URE40enecm1Ly1Cw13dmQ/jIPudkXHpYnNDPZo6zmrd4vAW8
	0z2Hb9IV/MgW+WjBDLS5S6uxtbN4fAEn4J5sMBMAAf+gjNNj6eQoFdhG5cn0I5jk=
X-Gm-Gg: Acq92OEpaDg88a6a8RVYO1g2ov2r2P9IDEF/W4vYc7ttUfEi2TlNJk6O9A5eeliwo7E
	tFXQM0wjdT/eFgjzkxBnJlT/eQukTWAJ62OIIl7GRU7I0Tqmxh3ldaDTMDBAl3XYVWZ86BMm+zV
	mPpS5mHpyqKK2Kf2nIyniJFiVefy2qrJQLx/HrWYzMgGFC9O/r7Mse/e+NJeTd1/rC6mBRB/Psd
	EKPFUXn/NXhZWmcP2hBH1dMnA9sIM25r7Osnwar5wiMiJHJlbLrJxuMvOMuoGSNsS7JJOutPYx0
	nfwcOavUhCX+ZVN5GS0VpFU4c/L2dzgB3gsuRZ44Y9EVCqXtKqWAWX25uWhXSI7QMha7v8vZhUv
	M0eh0jn0aZ8SoAvnqaFTqPJ3n/WC0eQrTcDV6mX4K7RQkF8uapqU=
X-Received: by 2002:a05:6122:3784:b0:578:9e26:e439 with SMTP id 71dfb90a1353d-5789e26f35cmr5125428e0c.10.1779196708971;
        Tue, 19 May 2026 06:18:28 -0700 (PDT)
X-Received: by 2002:a05:6122:3784:b0:578:9e26:e439 with SMTP id 71dfb90a1353d-5789e26f35cmr5125360e0c.10.1779196708538;
        Tue, 19 May 2026 06:18:28 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:3fb6:74e3:3c25:ba2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe7dd22sm143969195e9.7.2026.05.19.06.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:18:27 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 19 May 2026 15:17:52 +0200
Subject: [PATCH v17 10/14] crypto: qce - Simplify arguments of
 devm_qce_dma_request()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-qcom-qce-cmd-descr-v17-10-53a595414b79@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2674;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=z8R+ergOMQqtDBFCzhyJGktXjtFI7hHEfPs4Hn3rlAg=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDGMKVfVhUnZ6X9Zd2Eo0bF1f8BSs5/ZGQpiO9
 hV6+UnhtjGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCagxjCgAKCRAFnS7L/zaE
 w7IdD/4nEEUBAVXy5CuT/Ir8QkQouzdfD3V53LDe1R7dg2dyUuk+VJShWPPRnTGEo2C0+a7Lezj
 L7TGHgPbJISccas+3c1Z1GU0uzYZXtAGaj4XNiObEQILe7fiN0Z6/vmcfjyH4chgDlRWClc5kOb
 7nwVCfqJHBEupZjPPUMGQJI6rD7sCHR7ydkVxN1rGk1ofXG2tj7PGKJqrQErTQtaQXPU7ppCJ85
 yP2OaxDbw8QvULphApl9Gf7slKPi+vUOOUElsvlSBo22/ZNl1o82pgRVxdCdz+c/6ndppXII9jo
 M25dEd9CL58BFTj7cvsoDpWbzorhU7HYAwitKMVdK8EZQTqzM+dIYDcH5MjqGayV68kUVwTuqug
 UVk02hexvaEWxSpI6ctGboeQecBGkMuooqebMVKwoMPA7aoPYp6tFUNM6j102j4C3wSAw4oXBf1
 U7fpcJEvPoQXepRe7zHxsmTQvaPuoOG4sC0nXAsRDYMwoRbWC+Pw37ft7P8YptBYtG3V8U2Qyh9
 A4cz4lYzuokzHq52HD0erpEhUO4/msOJEHQ2ecCe9HSxH68cezqYiAqlVHo6dhUYv+ZIrAnZ0Ce
 iBS7bak7gPcQOgaJDxow3yNptpGzHcunMrxoKKbcObWiaTZqyplN7o2hVGcYNFBwvyZDuloQSqc
 pa//L2nDAR8MTUg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=JKULdcKb c=1 sm=1 tr=0 ts=6a0c6326 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=KKAkSRfTAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=lH6k5GM5CfRwGFUYfCYA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: -e5DQ2v2LsqvTtCYLdmVv0Ln4JCzR_A-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEzMSBTYWx0ZWRfX4ilw5QJeWvwA
 CCV6AtsPleJSPTwizSw0fgRAmWsUWgCW7KijVKD/C8ioxq6hHqFon/NwLwJZDS2BQdhcYtqmZOW
 x7BGxIhz6EIMzu/lv4MCNlpr5RQwAKSq5Q1hjIxayygrhRRqqwV39I2un8H3v3qkzVvsRVYZzFd
 OUmNks5Bn88slYeD3wCeBNSWpKibvX4CKCIMQ6JQlIK78hmGjT3RpPLCn6QbZWOEM3R7+o9rtlE
 hJo1mpcg6zK2ck/y1WAIrFA1qmOff52V8eIpE47l4e/Ptez1qbjydS1JmzKuIr/xo8oSRK+Dvko
 A6uejS3IF6wlPw7KVHJGPQ3he+x7fYQBWGnOflQtFUx3ZmUCM+d2VOO115uORVf4u4RIEMmBtAO
 c3XatskScetcpdLSG2nDdWRgXGUgAChH+BFStRC7/llYuEC7X3u8e7YcCvNWfmkb3RCawpcPX1S
 CQBuow1ao/70K6zKOPQ==
X-Proofpoint-ORIG-GUID: -e5DQ2v2LsqvTtCYLdmVv0Ln4JCzR_A-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190131
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10545-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Queue-Id: 349AB57F80E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This function can extract all the information it needs from struct
qce_device alone so simplify its arguments. This is done in preparation
for adding support for register I/O over DMA which will require
accessing even more fields from struct qce_device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/core.c | 2 +-
 drivers/crypto/qce/dma.c  | 5 ++++-
 drivers/crypto/qce/dma.h  | 4 +++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index 5f724db7c65930991218557394d99574418fb68c..90f44db6606173d8afbd295a6dadea177b7bcd11 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -233,7 +233,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = devm_qce_dma_request(qce->dev, &qce->dma);
+	ret = devm_qce_dma_request(qce);
 	if (ret)
 		return ret;
 
diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index 08bf3e8ec12433c1a8ee17003f3487e41b7329e4..c29b0abe9445381a019e0447d30acfd7319d5c1f 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -7,6 +7,7 @@
 #include <linux/dmaengine.h>
 #include <crypto/scatterwalk.h>
 
+#include "core.h"
 #include "dma.h"
 
 #define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
@@ -20,8 +21,10 @@ static void qce_dma_release(void *data)
 	kfree(dma->result_buf);
 }
 
-int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma)
+int devm_qce_dma_request(struct qce_device *qce)
 {
+	struct qce_dma_data *dma = &qce->dma;
+	struct device *dev = qce->dev;
 	int ret;
 
 	dma->txchan = dma_request_chan(dev, "tx");
diff --git a/drivers/crypto/qce/dma.h b/drivers/crypto/qce/dma.h
index fc337c435cd14917bdfb99febcf9119275afdeba..483789d9fa98e79d1283de8297bf2fc2a773f3a7 100644
--- a/drivers/crypto/qce/dma.h
+++ b/drivers/crypto/qce/dma.h
@@ -8,6 +8,8 @@
 
 #include <linux/dmaengine.h>
 
+struct qce_device;
+
 /* maximum data transfer block size between BAM and CE */
 #define QCE_BAM_BURST_SIZE		64
 
@@ -32,7 +34,7 @@ struct qce_dma_data {
 	struct qce_result_dump *result_buf;
 };
 
-int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma);
+int devm_qce_dma_request(struct qce_device *qce);
 int qce_dma_prep_sgs(struct qce_dma_data *dma, struct scatterlist *sg_in,
 		     int in_ents, struct scatterlist *sg_out, int out_ents,
 		     dma_async_tx_callback cb, void *cb_param);

-- 
2.47.3


