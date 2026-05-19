Return-Path: <dmaengine+bounces-10537-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJJlAk9jDGpXggUAu9opvQ
	(envelope-from <dmaengine+bounces-10537-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:19:11 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 375A857F723
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9BE32301F4F0
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 13:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51CB4DD6EC;
	Tue, 19 May 2026 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lDAipbQp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cv8jwuZg"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0452E4E3790
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779196696; cv=none; b=IRKnlYulsBbaFQ2xZMzm9YULJbbJ2UWlgPhHmrleBUL1bJj6E/bRt0KIG0tvkwE2hA2vskxsdC56Vz37hncYfGFTLMbVzuppK3SqVzHKTl8KrCKBDyb77atSQYJmNwhSSLCEgIeUcf2mgBIDCq0xBf+mz+VqmMKhDaDRM047rP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779196696; c=relaxed/simple;
	bh=dAO3Z255k2yGXbKKHljWmfMX0+7AVaeyaum6kFL1QWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uxI63J0QYEdykhpN6sC/fKywe3en19pv+VBGGxYkjauQi92VGDfHio7joNheELX5si78I9ykYMrKc7MvspNfNcfWnNwKLKfPtlQ8f/nlHrLbVuf47woKLwRsGqWA7MYCEj0h5phzUhqh5bcpDFPqPJmlTvXux2fUhL6IRZ0eg4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lDAipbQp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cv8jwuZg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J9v7qq1054831
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:18:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	94MEU9aOFWh3av1FWToR/uMqLJdnwEcp9tKREkNbm2E=; b=lDAipbQpmkAng+Eu
	KkGXJ/8nrstxmlovaUnE02drCwjr11UJW4zWjPbS/ZeLkhh5YN1HqmxtU+MeeJ6Q
	NiU/SAOXBkc74TOzwmmQQXrN+jVJ9tnOvx8SXT9JxwNQeIYESJlISWfuYRlaR4TP
	Cl6j7gAuZW7IMVS3bT6lc7GujXKg8eaorbRXJ8JJU4zW1N4IIw6BXHrhfrP6bITh
	/KUfAdzh3gb0GNrhv89X4Bsfhm7OLLcLgSph4hCo0pzjrDpbMZUVxAvOCKSP9mh3
	3IyPODgPDkWX1eZzn2GXJC6FA4lBAjOJflVTPDdiCBk8exg6Lx8J4dzmq+4NHfHa
	Ay+2Ww==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8nparrh5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:18:13 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-69d4c069cbbso465696eaf.1
        for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 06:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779196693; x=1779801493; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94MEU9aOFWh3av1FWToR/uMqLJdnwEcp9tKREkNbm2E=;
        b=cv8jwuZg2p5AoL6HIlsyTcEsW1zbIzEgIqZUZU+uQl6TseXOY5b1jO71AJO+kTCvTv
         1miqpMEqTCSf1YSb0quVyeQuoEs3o43w+FF5OmB1tSmNevwxqPzJ4En6EkASniDqOAT2
         bKlVXZktFH401syj9mMfdYpW4L0UDauLvI7wqDAsnGoKXgJ9DU9B4Ap3MbqRsNcNFe+i
         EfL6RSvatcpUqh2as8sWpWqjSP0xaUFTE4e91W68/f/WUUc1RImK3DJCe2gj1ZbvM4iN
         PfhVbo14gSxQZLvWPEQS5h0ThnUXbDLimdXGMix6dQ89P90PZJZsNCVt+6xhDdVpdnmu
         T2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779196693; x=1779801493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=94MEU9aOFWh3av1FWToR/uMqLJdnwEcp9tKREkNbm2E=;
        b=fkxJEAl3m9uRNI8RE0FLunln87DnNjOflXBzdW/g9FsewTn2jbP8j/qG/Ui/hPr3kl
         b4ealWqvqypAEdYZmwWnjZ4VjsjmRhx8FOXVE4raXNPKYkelpXY7Jnl/4Fb1S4CRkc2X
         DyK9Xt7FL/qZrJ2EJA3ERqdtQHRTShv1f1labZRI9gwjM4Q1tly+Q7akhZhaTM2vSW6l
         DlqVYZAmTH09jR0FbyYXDMJCb7puQ6iR/OBf/iHYqUbT7c+xe4+zlCnm6iWZoyZAFQAx
         S2CrtJW8XhyNHThW7wjdFlWhww405Rf3NShZwp/h62WFHNF8QyOSt4L1WCFzKbT0Jiw6
         ZznA==
X-Gm-Message-State: AOJu0YzvOdCgzcOhICzvZAatxjtTQdMeMxpjnhnC5n/+tZTjERz9yEc7
	BZzd93Q3rUEahv/w9EwB82i3T780Wgf/sSCYcJ9zYGji9rJfft9GUMrUFSy7V9ZsWywHEXtSQ8U
	UT6sH9tO7RSsYBDLLgRtJHps+i6tJEMFZvkhqa2mNwmXKt0qCFk86jUYBIwdZFEU=
X-Gm-Gg: Acq92OG3DGRVrKwSrf00YI38Uq38Z7xIpTXNMNqD9s2Tl6qwjOs9BQUY+bZpLgXa0cD
	CRG37UHd927dX7p8vXSQKF5xj3delgfxpSDpvwk1KoDtDeYpwAZgtlfKErJx/Nyom1Yt4bOYyvE
	K/gViV76flYLVjDqR6S0PDSqd9spw//DiMq2Mpg5DqKWIAnRN7i18hDHvrzhROkeNi/B+lj448w
	tPCljkgj+QK5AzeDBPcrfxxEc+p0SP2rhfgpj4aR6w3beUbT/eN08QRjFjpAfPPP0y7GC7UpxTc
	WX7Vtuz+EZuPho7ycayt4LQ1TrwnUesr+2bVHVN6gMmwNDkKtF1HND/TRPa8eU+6fBhKteHR2mw
	eJCWMXxaeiOT6f0f1igiIR3PVk2HYZ5W9OuhXJkPQ03pZPpA8gKI=
X-Received: by 2002:a4a:ec43:0:b0:69c:5d2b:4079 with SMTP id 006d021491bc7-69c942a5fcdmr10530464eaf.6.1779196693253;
        Tue, 19 May 2026 06:18:13 -0700 (PDT)
X-Received: by 2002:a4a:ec43:0:b0:69c:5d2b:4079 with SMTP id 006d021491bc7-69c942a5fcdmr10530424eaf.6.1779196692725;
        Tue, 19 May 2026 06:18:12 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:3fb6:74e3:3c25:ba2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe7dd22sm143969195e9.7.2026.05.19.06.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:18:11 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 19 May 2026 15:17:44 +0200
Subject: [PATCH v17 02/14] dmaengine: qcom: bam_dma: free interrupt before
 the clock in error path
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-qcom-qce-cmd-descr-v17-2-53a595414b79@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2456;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=dAO3Z255k2yGXbKKHljWmfMX0+7AVaeyaum6kFL1QWE=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDGMCgf4Vg3jkO6YzGQwECnhi4cg2IDvJ0MkJA
 qlIVBYqVvyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCagxjAgAKCRAFnS7L/zaE
 wxwyEACRCzcpf1dcbSVhnrdOK6MTf2WN4sYADdEAPSBg7UExvO/UAPlKbl4qWSCdbqI7Sp30dam
 1lBBbBw7SujcVDWQOamidvxiW+AGaNdHUcEO95FhuU78gpd7ByKTUz9+xTJJBisemx1svtYeCiM
 /UamzNbkqavi9AYibWEmWiqLV6NBsyF4Wcj8QSFctG6xl4TXXIl3tU/YElUXqNDEAedNpITQxaq
 BLXyS2cNPubCFvc8IVp50+o1k1MQB49qODiHF7laucTjgmGc2h2PrGBJWY/Sac+ZdEIipgh3DpO
 Te/YSMpogxRkvH0RnfWBJTC21Zt0/8OytQh/sOit4gptvQPsk9dEw6sMp63zV5ugFRHO1HE1kBc
 spfWrUXezLFOhFYBDAQe/N/nva0FOAPCQSpSjXjd8iIogCHEvZTa2VeWsYd4ZTrMDjF71ubzULb
 QpZ21NnUvQdw8tuB1P/TMzsnSYAOmLlQakLkdfbZwgPtLzn390zJOHP1c0JQp1zrkLZCCpa1utL
 zm96A7yhlH/3WgAxb6tAPw0nnTnT63U3tCAuh3Oq6BCq1orm5VsxFbJq+wiI7Tt9ypKCngVCJyQ
 pS12KthdJkXwzGsHqLd5FaTC6o2PhErY/dqeq7lFpreydBX8FFGYQ32CWybUlG9PFI1hqOSwvxg
 K59ziLTDl0U8l5A==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEzMSBTYWx0ZWRfXwqr3vQpV/GOY
 Q/JIrGYe0w7XOOYLCXCMqJkWp9aYFGE9A180Zio/QgLVmJrloq24JC6vJwnHmLZs0254sXCKcYo
 +pgAje6sTkhOwWZgpkIH7Oezrz0ryglwKzDmtqK88yHgme8OeLFR29C4hc9z4v9ZCaMycD9q23P
 MsXzdutlYrUrIkUaPRU9qttboALGF8We/DaRNImsqKCmp53ka0kAcIiF6bqUtgzKWbKGtnC6jrR
 LLLjjb55bM2o86jyO+21jMo1UtQk81lIOGTrzXrumeAJsvWBwNyY1cGtJLy6PI3TXOev9DQzGA8
 UcZsErHI3vjkl+86K86Nn5+XmfczN51hreltL9Ot5B+PvGJ4hHWmc7XCN1Q5xWc+A9OPJA6TuOB
 2RoN59j/eN3JPtKzxvNigxHJ4UP4wdG+WCv5Zs1T74GZA53M1r0cFwxDsqHpycmPOS2vk2X9Yc8
 nz6NEiR6yR9GS67a+3Q==
X-Authority-Analysis: v=2.4 cv=NrjhtcdJ c=1 sm=1 tr=0 ts=6a0c6315 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=n8zAjjMAgf0wD31B80cA:9 a=QEXdDO2ut3YA:10
 a=k4UEASGLJojhI9HsvVT1:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: 7VmTeWw5kjzX07i97H3_MUZ7K7oJBrEK
X-Proofpoint-ORIG-GUID: 7VmTeWw5kjzX07i97H3_MUZ7K7oJBrEK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0
 adultscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190131
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10537-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
X-Rspamd-Queue-Id: 375A857F723
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The BAM interrupt is requested with a devres helper and so on error it's
freed after probe() returns. We disable the clock before freeing or
masking it so it may still fire and we may end up reading BAM registers
with clock disabled.

Stop using devres for interrupts as we free it in remove() manually
anyway. Add an appropriate label and free the interrupt before disabling
the clock in error path.

Fixes: e7c0fe2a5c84 ("dmaengine: add Qualcomm BAM dma driver")
Closes: https://sashiko.dev/#/patchset/20260427-qcom-qce-cmd-descr-v16-0-945fd1cafbbc%40oss.qualcomm.com?part=2
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/dma/qcom/bam_dma.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 19116295f8325767a0d97a7848077885b118241c..cea44833201d641ce6a657840d354abb443501b5 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1302,8 +1302,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 	for (i = 0; i < bdev->num_channels; i++)
 		bam_channel_init(bdev, &bdev->channels[i], i);
 
-	ret = devm_request_irq(bdev->dev, bdev->irq, bam_dma_irq,
-			IRQF_TRIGGER_HIGH, "bam_dma", bdev);
+	ret = request_irq(bdev->irq, bam_dma_irq, IRQF_TRIGGER_HIGH, "bam_dma", bdev);
 	if (ret)
 		goto err_bam_channel_exit;
 
@@ -1336,7 +1335,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 	ret = dma_async_device_register(&bdev->common);
 	if (ret) {
 		dev_err(bdev->dev, "failed to register dma async device\n");
-		goto err_bam_channel_exit;
+		goto err_free_irq;
 	}
 
 	ret = of_dma_controller_register(pdev->dev.of_node, bam_dma_xlate,
@@ -1355,6 +1354,8 @@ static int bam_dma_probe(struct platform_device *pdev)
 
 err_unregister_dma:
 	dma_async_device_unregister(&bdev->common);
+err_free_irq:
+	free_irq(bdev->irq, bdev);
 err_bam_channel_exit:
 	for (i = 0; i < bdev->num_channels; i++)
 		tasklet_kill(&bdev->channels[i].vc.task);
@@ -1379,7 +1380,7 @@ static void bam_dma_remove(struct platform_device *pdev)
 	/* mask all interrupts for this execution environment */
 	writel_relaxed(0, bam_addr(bdev, 0,  BAM_IRQ_SRCS_MSK_EE));
 
-	devm_free_irq(bdev->dev, bdev->irq, bdev);
+	free_irq(bdev->irq, bdev);
 
 	for (i = 0; i < bdev->num_channels; i++) {
 		bam_dma_terminate_all(&bdev->channels[i].vc.chan);

-- 
2.47.3


