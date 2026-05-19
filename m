Return-Path: <dmaengine+bounces-10541-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mByvN3djDGp8gwUAu9opvQ
	(envelope-from <dmaengine+bounces-10541-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:19:51 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3BD57F780
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A4933042AAE
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 13:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704E24DD6FA;
	Tue, 19 May 2026 13:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fsq9SJ8U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CPxgTD/K"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C87348C54
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779196705; cv=none; b=VVIKHRVoBghYMl0Hfvdjg5HucIrJAnXhVVd4djhkaW59D7KrnqTZprIyN3UpClNvApe+e163MZpWAMNDeYA1tRAaCBjDZ+0KylECGmqef8uUg/3F8P8tgJAddKyp530Le8/Chd+9beG8fORq961WTQxsTAhNmV0VQTgwYmhNp5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779196705; c=relaxed/simple;
	bh=ou7/7gbS1COpHpqqL8bMYn/SVA9UQ3BGI8E9HPvHb8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u/ykmDbpBMFF4sh4hAtaLh8ULOtDjq/E8fILtuFDGwQBs3pv75shZvkFutmrro6UIs5lfFuIlxXIxvKeUAbBYtQOpTnpRuhQ0l+bY3lBZsbErpNd8dsMxyqN9pqWnu22EqOS+6sVpoZFdmWDlkbAXJW7vMtNf11JdZdbk3keWJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fsq9SJ8U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CPxgTD/K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JCDhNj1737092
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	akHZIQ2lTa9YJd4Hisg5vwjBVG+rmsCHb+zmNsMB/NM=; b=fsq9SJ8U4IA+Hvzh
	zJOOJL0KgyYePe9a4GJ4L+5QD8gJ85vWN1ta5fmF0iCTWHuh6B/Winpom6UPG9NI
	IBnvxLr1HWItamCFeKvGXfm/fLILfkp0rXWre4K72XeEyg8SHR/U7/2FZYvLq7lB
	GzvwmncIIz8r914hH968YFsc6qTL/N3u2mGmeoj/f6+u3PxVd6gzi5Y92m3lA3kg
	mBw2iwI9+tPQW3pBg6Si3V3bvpKvx6cP5FqrC9Vt05CkX2btN8p0vgCqDr/JtEyG
	W/FrB23AVz8ALsIhFIevcqODzaL7Rh8o5ak8I6LLkFMIYLUjOLJd2RSZf8iR2yWp
	N4+geg==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8ju91jkk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:18:22 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5752402f5e1so9491229e0c.1
        for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 06:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779196701; x=1779801501; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=akHZIQ2lTa9YJd4Hisg5vwjBVG+rmsCHb+zmNsMB/NM=;
        b=CPxgTD/KzAqMPgaX/e/z1TcGvdiEXY6JaseDQrDT+WaUGYyyHHaLi+1gjdNYQ/fpsJ
         S+4OKeTqyoiZnySEMSdpGIl1CyE7Y//fZuf/L7inRp/saFoVil0uskHBBrZQHIITyeuM
         zjb8tejRp+QVjopRlkX+MFedhGTiXOuU2efEAF5bMXASNL2yfRZQ1DZcz6LqvkrVbZum
         FvVKHRBI9oIVrXWtGLuh5/u3PjfD6+FqiGL0iLWu9VrFnGuWtR1bpLeP6LFkhND1cXlx
         A9qwyASvJ0lZ+nd4AuVkm7c8jqleE4MVFBqatHWxuejLz1sBKxNEySFaT1OfezflEfH7
         iSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779196701; x=1779801501;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=akHZIQ2lTa9YJd4Hisg5vwjBVG+rmsCHb+zmNsMB/NM=;
        b=lpgQH5BExDv9zxkuCJqShkkFUbWHRg0EY3DRD6jR4mTK7y4KySr1UmBgM1Z+rWP165
         WyJ+68j/Mp3KbFxnlMOr7/wa748kQYQfEeaZPiZLPGJb06b7YGkMU/ITPdFs9escny7O
         t5MNDFHGRTHmHnywe91tvhpjpbx7yajhNMvjXjg6mwggs9E/P5qegqsKDWCjwz3O+hvL
         K5fxMq9lTUgEqWYlQprSMlm4i4P+Dm0p4ZuwHG/3k65KHd8RePDCTBOBE7xwPqnaZi+i
         kj/QXNEDYtC8irSs45FT2Q6Ah+jw4xNwIUaa55/VjgyoFc9UvCMNWCj5rbXgw+X8TnRR
         Twdw==
X-Gm-Message-State: AOJu0Yw8mLf3FSPzxawCRwD3YBJqwZKXCTVLXR9LiPg46pSqKjlrKHPz
	tQQYCz8kxHkFoYVsleUqGn7Dm/sZiUxqOd0s8OOPAaRMGtBaxIdS4WO19BCiQvYPRJAlsMXQ7OC
	4kcX7T2StK7SdwLJa4vOKNMRkZz5kWbQj5geTcnFx3tXotoDVOPbxRMHxhgzTC36dhttLtqk=
X-Gm-Gg: Acq92OEno6ecLaYV/8/6msaDw+lClHD1vmqWtIQIbUU2RPGCzOFwRiBDtRufmV+GBXj
	FIcfCC7M8Jbajvn51ATPLj+SDFXEFYAAFbhyv4WAkKi6+DBh7B0Qk6dI59puLTVtTYnxRV5BouB
	4mKfPTY9a4UIxmaEuyIjRCV9mjaC/iv0A5MbbKRamCN0mGzUgPwIdzYka8rbpZH8Lp56wimaXwU
	ZzuDnqnh6Z+0tGWvLL9O0SCotsc3o21TdNxqjogbNZQninMHiRSDsG/o6glhLOZS3UJXspHSiaH
	YrLGT7JjVss0m+4Bjs0t/dfeFFvkJ3EJOGpTwzq5fVKLKg2ijS+OYNhfk9yvh9uAwlGPb2TvAbI
	RCBtUTmtC2aLrQIETJV1IKfwdCX+ir5VGllrOAxa+v9/M9E/fXyA=
X-Received: by 2002:a05:6122:2407:b0:56b:7d4d:4d11 with SMTP id 71dfb90a1353d-5760be39b7bmr10552783e0c.1.1779196701167;
        Tue, 19 May 2026 06:18:21 -0700 (PDT)
X-Received: by 2002:a05:6122:2407:b0:56b:7d4d:4d11 with SMTP id 71dfb90a1353d-5760be39b7bmr10552747e0c.1.1779196700723;
        Tue, 19 May 2026 06:18:20 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:3fb6:74e3:3c25:ba2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe7dd22sm143969195e9.7.2026.05.19.06.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:18:20 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 19 May 2026 15:17:48 +0200
Subject: [PATCH v17 06/14] dmaengine: qcom: bam_dma: add support for BAM
 locking
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-qcom-qce-cmd-descr-v17-6-53a595414b79@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9563;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ou7/7gbS1COpHpqqL8bMYn/SVA9UQ3BGI8E9HPvHb8o=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDGMH/r5kKOanWDNGv7aNf+1HsgjHFZfVno5NX
 E3lPj98/7aJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCagxjBwAKCRAFnS7L/zaE
 w25/D/4thliACpwThd9ZAX8Ctdaxbk21PFdu9DRCGcmQzPfLFgbA9V+Fo3vyV6CpUR1PBcLkagQ
 QLIYIIw9hrh6T59wUaTQWPzSpoeiXunF9ZYknTAif2CAOwM/D0oiDyvou8tkDpIphnTyBDkhP4b
 YT3UPqmRU1t+PoseFVRtRbyHYLDc2GUxgnwg9liiQWPF9PmrUyVUQ2WAZvwp/wetukmOPOnfjwA
 tMnES2Y6as3P4xxSLxt/c0Ho0y8+WNDKwsLrmyqVAB+vYefmj2gVS9gGPwQGcpmA0jiOlZdmW4v
 eSArjpQaRDh5R5SeR+qr9fIltXFNOAIGd0URJVMXPkquF4eMYYdaeAx0c5CK0KRoBt7jEmeB7DF
 rotaMZ+ky3cPVgKIt5aM8hJ+4DbPfusjtaiOa9PSL5AnX6Wi233AllH+q5XZnGDsubO2a8eAmZp
 E/TBYtjw74C/j4Y1Wtzjug14HX3Xx2r2+7po+UMaVQwkIMkgajfNPqFCH7y3+k/oURe6U3L3h7m
 r2ENP82in9rixDmVgXkGBvXPrxK1Kw3onR3S5yANK3BbSqGPytC2aa6zQFTUHEC9WdgOuVpUEP8
 TEc2jOyagQCReYaDz1DlTkekkAvDoDvS3OQdsulpLncM3egAm849xo+as0/FflW/FHnKvnz8iL4
 oZXGp0pEAHZTqHA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: J6uLkoTHkl0KkrVAxilrFVMDWrxicAFB
X-Authority-Analysis: v=2.4 cv=eeUNubEH c=1 sm=1 tr=0 ts=6a0c631e cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=j-cXwOq41x9PnjJ4jooA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEzMSBTYWx0ZWRfX88l8T/jwl6R0
 f3w6Y26jZ7rMj1VJuR8Rde/eEa/ngF4P3omjLdag68utUrwy3wYZ1b7TVHeTomUFjk+K3LOOTpw
 KGqdOlyg46E5733aqB6JrW0NRjh0ugwegIgXKa0XCfoqt/TyR63IDiAucm2jLYfq33kaCbOhjlJ
 CbBO2wfS/IPild7vhbzq5nPIPpNeUccdZn39QAXBRUGGHsoFkG/LphdwT8R4C7wbfDPbY3qNhue
 XvYTeSTJLqudefLpjvRatemUWgaHY791hGuAaIT9vAZKpRmMAF9BROYAjB6uqpb2JnIdRXXlyj9
 c3HwpFM+Cw/pXFHveiK8PKt5kyfSazPOTcz/lyCGZo1a4y3KU6TNfJr5Qk13j5SNl8A9y8eB3II
 W79XZJfLR+mxGx76fn3YnB5LM680oB+L8NB7wn318PLQzRLm2RQdT24hAg7xB5s7B5XlPoCCQoC
 1b+NdrywZxHs7JErJZg==
X-Proofpoint-ORIG-GUID: J6uLkoTHkl0KkrVAxilrFVMDWrxicAFB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
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
	TAGGED_FROM(0.00)[bounces-10541-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
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
X-Rspamd-Queue-Id: 8B3BD57F780
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

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/dma/qcom/bam_dma.c       | 156 ++++++++++++++++++++++++++++++++++++++-
 include/linux/dma/qcom_bam_dma.h |  14 ++++
 2 files changed, 166 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 30318cf01ee20b7e64a988e8ce1ec04dab55e3c3..2c9f90313c313851f84ebea8d99e73b37829b297 100644
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
@@ -72,6 +76,10 @@ struct bam_async_desc {
 
 	struct bam_desc_hw *curr_desc;
 
+	/* BAM locking infrastructure */
+	struct scatterlist lock_sg;
+	struct bam_cmd_element lock_ce;
+
 	/* list node for the desc in the bam_chan list of descriptors */
 	struct list_head desc_node;
 	enum dma_transfer_direction dir;
@@ -391,6 +399,10 @@ struct bam_chan {
 	struct list_head desc_list;
 
 	struct list_head node;
+
+	/* BAM locking infrastructure */
+	phys_addr_t scratchpad_addr;
+	enum dma_transfer_direction direction;
 };
 
 static inline struct bam_chan *to_bam_chan(struct dma_chan *common)
@@ -652,6 +664,35 @@ static int bam_slave_config(struct dma_chan *chan,
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
+	guard(spinlock_irqsave)(&bchan->vc.lock);
+
+	bchan->scratchpad_addr = metadata->scratchpad_addr;
+	bchan->direction = metadata->direction;
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
@@ -668,6 +709,7 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
 	void *context)
 {
 	struct bam_chan *bchan = to_bam_chan(chan);
+	struct dma_async_tx_descriptor *tx_desc;
 	struct bam_device *bdev = bchan->bdev;
 	struct bam_async_desc *async_desc;
 	struct scatterlist *sg;
@@ -723,7 +765,12 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
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
@@ -1012,13 +1059,106 @@ static void bam_apply_new_config(struct bam_chan *bchan,
 	bchan->reconfigure = 0;
 }
 
+static struct bam_async_desc *
+bam_make_lock_desc(struct bam_chan *bchan, unsigned long flag)
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
+	async_desc = kzalloc_flex(*async_desc, desc, 1, GFP_NOWAIT);
+	if (!async_desc) {
+		dev_err(bchan->bdev->dev, "failed to allocate the BAM lock descriptor\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	sg_init_table(&async_desc->lock_sg, 1);
+
+	async_desc->num_desc = 1;
+	async_desc->curr_desc = async_desc->desc;
+	async_desc->dir = DMA_MEM_TO_DEV;
+
+	desc = async_desc->desc;
+
+	bam_prep_ce_le32(&async_desc->lock_ce, bchan->scratchpad_addr, BAM_WRITE_COMMAND, 0);
+	sg_set_buf(&async_desc->lock_sg, &async_desc->lock_ce, sizeof(async_desc->lock_ce));
+
+	mapped = dma_map_sg_attrs(chan->slave, &async_desc->lock_sg,
+				  1, DMA_TO_DEVICE, DMA_PREP_CMD);
+	if (!mapped) {
+		kfree(async_desc);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	desc->flags |= cpu_to_le16(DESC_FLAG_CMD | flag);
+	desc->addr = sg_dma_address(&async_desc->lock_sg);
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
+		dma_unmap_sg(chan->slave, &async_desc->lock_sg, 1, DMA_TO_DEVICE);
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
+	unsigned long flag;
+
+	lockdep_assert_held(&bchan->vc.lock);
+
+	if (!bdata->pipe_lock_supported || !bchan->scratchpad_addr ||
+	    bchan->direction != DMA_MEM_TO_DEV)
+		return 0;
+
+	flag = lock ? DESC_FLAG_LOCK : DESC_FLAG_UNLOCK;
+
+	lock_desc = bam_make_lock_desc(bchan, flag);
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
@@ -1030,6 +1170,9 @@ static void bam_start_dma(struct bam_chan *bchan)
 
 	lockdep_assert_held(&bchan->vc.lock);
 
+	bam_setup_pipe_lock(bchan);
+
+	vd = vchan_next_desc(&bchan->vc);
 	if (!vd)
 		return;
 
@@ -1157,8 +1300,12 @@ static void bam_issue_pending(struct dma_chan *chan)
  */
 static void bam_dma_free_desc(struct virt_dma_desc *vd)
 {
-	struct bam_async_desc *async_desc = container_of(vd,
-			struct bam_async_desc, vd);
+	struct bam_async_desc *async_desc = container_of(vd, struct bam_async_desc, vd);
+	struct bam_desc_hw *desc = async_desc->desc;
+	struct dma_chan *chan = vd->tx.chan;
+
+	if (le16_to_cpu(desc->flags) & (DESC_FLAG_LOCK | DESC_FLAG_UNLOCK))
+		dma_unmap_sg(chan->slave, &async_desc->lock_sg, 1, DMA_TO_DEVICE);
 
 	kfree(async_desc);
 }
@@ -1349,6 +1496,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 	bdev->common.device_terminate_all = bam_dma_terminate_all;
 	bdev->common.device_issue_pending = bam_issue_pending;
 	bdev->common.device_tx_status = bam_tx_status;
+	bdev->common.desc_metadata_modes = DESC_METADATA_CLIENT;
 	bdev->common.dev = bdev->dev;
 
 	ret = dma_async_device_register(&bdev->common);
diff --git a/include/linux/dma/qcom_bam_dma.h b/include/linux/dma/qcom_bam_dma.h
index 68fc0e643b1b97fe4520d5878daa322b81f4f559..a2594264b0f58c4b2b1c85e243cad0d5669c26dc 100644
--- a/include/linux/dma/qcom_bam_dma.h
+++ b/include/linux/dma/qcom_bam_dma.h
@@ -6,6 +6,8 @@
 #ifndef _QCOM_BAM_DMA_H
 #define _QCOM_BAM_DMA_H
 
+#include <linux/dmaengine.h>
+
 #include <asm/byteorder.h>
 
 /*
@@ -34,6 +36,18 @@ enum bam_command_type {
 	BAM_READ_COMMAND,
 };
 
+/**
+ * struct bam_desc_metadata - DMA descriptor metadata specific to the BAM driver.
+ *
+ * @scratchpad_addr: Physical address to use for dummy write operations when
+ *                   queuing command descriptors with LOCK/UNLOCK bits set.
+ * @direction: Transfer direction of this channel.
+ */
+struct bam_desc_metadata {
+	phys_addr_t scratchpad_addr;
+	enum dma_transfer_direction direction;
+};
+
 /*
  * prep_bam_ce_le32 - Wrapper function to prepare a single BAM command
  * element with the data already in le32 format.

-- 
2.47.3


