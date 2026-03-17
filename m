Return-Path: <dmaengine+bounces-9491-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLEPLDJguWlsCwIAu9opvQ
	(envelope-from <dmaengine+bounces-9491-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 15:07:46 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E0E2AB76C
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 15:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 996D730A728B
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 14:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46263E4C97;
	Tue, 17 Mar 2026 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YDNtySmX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gsyE3VxM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C817D3E3DB2
	for <dmaengine@vger.kernel.org>; Tue, 17 Mar 2026 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756187; cv=none; b=qZd0RB5KE4+uGHcQgLZGatq6IBluwH9gqt+MhTSWc3KaKLO39SHsbQywdWlqTwHkKtjauByd9sOJ3KESNB/IHIJ0N35W7L6xennwVSO6kWN55GSq7Ax1BSqCNCd7QeEgoLxvCIzw/x7+60raJnyKMyEnI3qGTPpzRSS6rQXUIj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756187; c=relaxed/simple;
	bh=FnVBtOe0OnnBy34d5WsqwWSUvkeiYQ93/vJc1qwp/2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nVOVihfNCyOIdKhvxRDreRrOoAhUa/zuY1PP8ZyO9MIi2Km++ejCzmi7vofr8ZCcn+6bkRogd5boXV6XKlXPgQ5gp8AjPDz6IEA5nlRaESFavQPaKN7wbAl6TLr/v5HMsMnAd+x1j3anUcwSrmCss9/VmgbkMRuX1vBEE1xO/j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YDNtySmX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gsyE3VxM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HD4wm4668927
	for <dmaengine@vger.kernel.org>; Tue, 17 Mar 2026 14:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MnBQFcKPOgFHzTGJJB4DToRykxT+JvIdZWyKHEJZL1c=; b=YDNtySmXX4XlOATY
	yk9X/dvdLV8NzjGiSbTXSe4IHF8LFEeWxkHT9Scs4wA/cKVJhhGaJnwdCKwGO0oI
	0gx+bLf+A66FM7++3lCMTeFZ88glVRQjssJDjWcuDIeXMcsabgvP+7++zXQwqlf+
	+jcfGWkQF5Ty2/HERlLXw6Ks37Mg1mBB50Zlcl+xnY49dEwilsk7mpysYn1/G6jQ
	IRzHGZJtM1PFfotkjty9pVtWnW8phXiyTkGBhTnfJS6ijMQPmqGhyP2Nq4hMyjDH
	pOVojcpOOf/DfRGtdZMEMOxXNI2psvnhOtBFv55UEWPMidiDJm5ThokKcVArKPwv
	jrzTVw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cy7he06ww-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 17 Mar 2026 14:03:03 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5ffbe27449cso6125645137.0
        for <dmaengine@vger.kernel.org>; Tue, 17 Mar 2026 07:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773756183; x=1774360983; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MnBQFcKPOgFHzTGJJB4DToRykxT+JvIdZWyKHEJZL1c=;
        b=gsyE3VxMhDcCyCWCnfJ4AIY5eSU1PUxOCUNsDaMjxkpueeXNiYPsRU94Fq6NNVZIf5
         ruZvknN4wr3sXt/GJqyDrYJ/mCMYk6A2ajs9W1AfmEKYdYLMkGobF51ktI1zjX0fEe64
         BQt0M0PLHxjAd6/nYRcSkGHwnkmBhxC2KgWoOskpkx/bJM/CbJn+09QIUSSVbSqA8/1/
         SKPOaFJMiqVY3lY6Xa479+F7pM1u5qVleVO8xLkmGZGd0FZR5qxBvYcx6Lp+kyCDTq0a
         As1jNmLOdq7NlGovQlNRnojbNsIqhcn2VX3YxxecVaEnzhpaxUe/qJD3yyKu8ak3lSRX
         yCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773756183; x=1774360983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MnBQFcKPOgFHzTGJJB4DToRykxT+JvIdZWyKHEJZL1c=;
        b=g6dovEsjuwDEm6uE7iQRwefrOryPRSl6Ifhs81AetVT/iBT4Kf9kde9/4bhkUBMhzm
         n68LBkTTEM+H3L7zGs7EjzP6pwgM8tXwauiVTS0lzMksFjhGatoE/8Gc/APaQW/O8a2G
         vtUfaWBPXmyfri35jL9kMQV6WLF1OmvbrDLyvWr5OBnFe3VXyUDSumdhRKzH7uqbWX2l
         S8aGFI90bUydNjNX7uGbqtF78OD4ExvlSeCTSOGK5MfSRPkFaiV1CIi9hFU8GhbRXs4E
         6rYwvmn52S+lRZDXU1qobaC1Gi0RFHjzFK9eJXpWMuYoBz7lnzYNsMz2hWtXl4rPkY4V
         6akg==
X-Gm-Message-State: AOJu0YxFfdHaMUFwzMLh8V8NMbNYrRfJdfNM4rHx4NzP1zxbHA/WWmCc
	7nrY2MLo2iV0nCFKzXmEfELIss0D+NUGddv699UwlfEl/kYZk11KwjApF/9ceGlVyk/4qxODso1
	WXnvfh7nK5RbJtOVXVHd1wrNl7qC9pYSiKc0VJZEmnyrqbVxm7sb0+zjIahOZe08=
X-Gm-Gg: ATEYQzyukiKJs9c/7vzbOlTDjm5SMh/j0djUkVwKdlf9nAtoFGT5D5y+qOGa4d+VPcc
	rU6iODvhcXovqDHjjs0Evwiu2ZaXW0GxEC5YYxhGxU23spgRCw6TVPX2rgbAFBrrILynR+3NeFJ
	KhGjhFkyRoSC59xqoWpAiQXZhx2Eq720RcXZlLTskndbfcMW0PES9fiKvhckhp8s8DZShmn+SVr
	W1LR8fqOA7QCjbL5ip9Thtec1YJc5/gRB1Kov12kyVkZG18LyJqlNQZXDnGrK8iItuuxzqgHhDU
	sfPYzxv7kmiOuJFbGQT6Ek7iBmhj/XfRLmucdllZi/hIKxHVwx2lpqm0qUSIZ7M2JbSMhQ1xWSy
	7BZvYrqL/F3abUnjs59Dbv0vFC5IgPFeRrTkeyzlpqefHtnboVSoV
X-Received: by 2002:a05:6102:374a:b0:5f5:3739:100d with SMTP id ada2fe7eead31-602639f0278mr1650026137.0.1773756182990;
        Tue, 17 Mar 2026 07:03:02 -0700 (PDT)
X-Received: by 2002:a05:6102:374a:b0:5f5:3739:100d with SMTP id ada2fe7eead31-602639f0278mr1649926137.0.1773756182244;
        Tue, 17 Mar 2026 07:03:02 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:6aa2:dd35:4d6d:8eec])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b4938854csm9359709f8f.34.2026.03.17.07.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 07:03:01 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 15:02:17 +0100
Subject: [PATCH v13 10/12] crypto: qce - Map crypto memory for DMA
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-qcom-qce-cmd-descr-v13-10-0968eb4f8c40@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3159;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=gRGqUxioVpJcY9zBfeIZn1vIilzfanwkfyseaIOaQFk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpuV76HVh57AgP0R+TYtCCz0g0UnQ8j5eW4E4ty
 3CYzoK/296JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCable+gAKCRAFnS7L/zaE
 w2A8D/0Z038+TobMkyZZqP+SDSSDNwa1odcRZSoyNzjcRFTBXMa6SJJ3snAENqMgYG/RnAcvhd4
 iNsvGJ1wpEWRbDVYRPP+EnVSbmI7/Ukg3r0LfbUHIW7tcUFbqes5MU3jGXRm9mJRT+Ni3WhtFHi
 gkqe7N5xak2W3WWZa4YeOskjYaEfSVZYfYmBCE4Vxqnayi18XwhuUnBTiePeuPfJ8PaZe+Wx17R
 0jIyyHugkG8BrVJrpQSHJGqhcp4GKO+RMwFOAG+YKXBTocAaDWyjTspdoJa/pfCvs1SoZzE+7tQ
 +NryNOFOyvy1HFaeWJECfqio6gzz/NBvvy8IwNyhBeiZOl3TOs6g2PxMtCHooohoH12qS1I9Zyf
 gygZkIo7Fmq2B6V0eBLHrY7AlMY8J/Za0eJgOmThWHL38rp/8ZlajRN0zxpb1ujWDOH/wgSY+Rz
 tGh5nP4YayhiRQQ8+8PMKJrsIfoxlcJkoc52irs8nl9Ktvh0uxycW13joStLMyC19+w1JLgc4E8
 DOEzlU75E4tSXYEKMKc2IpLQYIze7IR3yE08OrBanNr2xW6nhxzoddz8j21AqNYSDdhui3vL7WP
 KcMvsmgbN5HQvSW9dMjn826yM7EAEYqGaS1y6GgJPbbq5VjiAvCnr1k9C75sjkRPG19IdzPzUf1
 9Yr1RMNxNIiY7Jw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: TYXpjL1t0l6eQDc4DDrFlNrLTJluz3QK
X-Proofpoint-ORIG-GUID: TYXpjL1t0l6eQDc4DDrFlNrLTJluz3QK
X-Authority-Analysis: v=2.4 cv=QsVTHFyd c=1 sm=1 tr=0 ts=69b95f17 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=76fuQ0JqpD8MvifAs1cA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEyNCBTYWx0ZWRfXxahYWG1ekvLR
 GXxhK/Wc6hUtbgenvEiEXUkLPzzr3YIvGP2Puy2Mp9QFqq6Hv3RgLThZXokVifSnXQZ2ZWmQzmV
 h1ABpj9XV2GQRnp0aO3ylxoqX+zOslQuEkSJV2/SCM8QHQf5QxrD8E80fN2QbkxlK4tMqzXFUHu
 qa//vmZKb1WOTQtoGNeHIt8Qnx2ytI9qIkRMKaUpJH14S0uE8UO4Y/BQ5rcrd9WJDReKbaex7Pr
 13pTdeBYLgf/8HzBWjx9c9BNCxyIBusuwviDjjMOTs3YhLnAI36uleAZ/eH6RVLUn2jHMO9Hkpg
 l7tsxp3jQXIDds0SSP3yHqgN4NIy91+uLaOQuqH63NR/STaIVomODVler2fy9VAbFX81Ul1vxQx
 psF14dY5u38AjoXOypZmsWAYayTsfJb39zyEglzm+41UNPtBw610Jnx4PbEBJKtGaJtl8dLqshr
 k+Lx1Idhf25pdhbEUMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170124
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9491-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 44E0E2AB76C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

As the first step in converting the driver to using DMA for register
I/O, let's map the crypto memory range.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/core.c | 25 +++++++++++++++++++++++--
 drivers/crypto/qce/core.h |  6 ++++++
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index 8b7bcd0c420c45caf8b29e5455e0f384fd5c5616..2667fcd67fee826a44080da8f88a3e2abbb9b2cf 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -185,10 +185,19 @@ static int qce_check_version(struct qce_device *qce)
 	return 0;
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
@@ -198,7 +207,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	qce->dev = dev;
 	platform_set_drvdata(pdev, qce);
 
-	qce->base = devm_platform_ioremap_resource(pdev, 0);
+	qce->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(qce->base))
 		return PTR_ERR(qce->base);
 
@@ -244,7 +253,19 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	qce->async_req_enqueue = qce_async_request_enqueue;
 	qce->async_req_done = qce_async_request_done;
 
-	return devm_qce_register_algs(qce);
+	ret = devm_qce_register_algs(qce);
+	if (ret)
+		return ret;
+
+	qce->dma_size = resource_size(res);
+	qce->base_dma = dma_map_resource(dev, res->start, qce->dma_size,
+					 DMA_BIDIRECTIONAL, 0);
+	qce->base_phys = res->start;
+	ret = dma_mapping_error(dev, qce->base_dma);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(qce->dev, qce_crypto_unmap_dma, qce);
 }
 
 static const struct of_device_id qce_crypto_of_match[] = {
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


