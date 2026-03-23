Return-Path: <dmaengine+bounces-9608-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIvFMkJkwWmaSgQAu9opvQ
	(envelope-from <dmaengine+bounces-9608-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 17:03:14 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AA46A2F74EF
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 17:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EFCE730885B7
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 15:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AC23C660A;
	Mon, 23 Mar 2026 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iMqbd+8j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aI0tOOsT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55703C65F8
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279079; cv=none; b=bwhU3AAs5tc6RwlhIkC3R8Iw+IEvdzZoK1cFMl7SvqVa/edUHdQhtURaWNMCY1pA6BzgSZy9bly/fOaQzwoZkx3k7LhiK2KO3wMk2t6xONVsrFxm5hdj7wOTAp8y5r3Fel+yvUickQGzwqKQWHx/MyFPPxB0/XRhRWozc5kgDgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279079; c=relaxed/simple;
	bh=0l3gdVnkPeEhRWmaFMSjmRRcTqey535uYCWAXzuHtwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A293xsnsZKvmBMpFIBy5qN1yzZxjNXIADSkaGdDJNWSclbbfnpJj5yratWimqQUDIU+7Hfe6M1BZ3XI74DMNq/ivPYl5d3xeuxycLWpkToesHx1NlyN7igNmyItYqsHvQvVoLZI0TGj6q1FP8W2r8yRDoiA0S3XTtm6HnFx+qn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iMqbd+8j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aI0tOOsT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NFGS4M2337021
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bP+u/9sMDsi5B9HZu73nJnAW0uvD7B1160U6L0iNO8E=; b=iMqbd+8jDFG8wUga
	CcAfEqrkXBhSqKa2mXvbxhMVq27SxEF4NFxU0fYhH2zkE9AQ827iCpiT8W0krEvD
	FRKYlEzzZNsyx5yLBaobqqSp38YUrgh11j72wbi6Z99og4kBRRuX0DUGKW1YcgPb
	JEu/rO8tCeQGHkzdusiLa5gX9Feh7n7xE442r/Ocj0P9fnfOaNONqB9qp7GAEy75
	telyxJjfOPRgmo0iAHvDQ0SUZWsKqZMYKESaYdFI1uiiqnQL+/CDel8vXKInCJyA
	IF7+XVgJcr1ObmM4T+odC7PAVgykfDysiktvMlq1FqHahth6YzPFHQyZRWHGeCX4
	YhPyMw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d31p79jaj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:17:56 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5ffba307845so32387873137.1
        for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 08:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774279076; x=1774883876; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bP+u/9sMDsi5B9HZu73nJnAW0uvD7B1160U6L0iNO8E=;
        b=aI0tOOsThrWNUMOipkqCm8inB7pmKAfoQR7vYiiFI7SRWtFUrlKHOszFy/zCBGM1Rn
         eY2KzG53o2zIB56ZXiktHZo1FAoXEtahPnOUcW+X6qkpiawiB9E34+85+h5gXSlZB9Vb
         SOxVassT3z1Gc95g/PFDGBsQ3YWRMcyby4xajt6xtDOFsdLSEAcJ8paqwxpzdeS+7HAC
         QorjF5adLqdj9Gp1uV9SZQSWlqsZ5uJJs6zjehrF4GJkn+HMPsQOsDezzm4RpAlrkIey
         QmoyngPB/dOJFjch9VQ41VZJ3p317Ea21AijKv8NFKZ205bdOoTRGtV6aUbyinMVpQZ3
         IhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774279076; x=1774883876;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bP+u/9sMDsi5B9HZu73nJnAW0uvD7B1160U6L0iNO8E=;
        b=NyJAITYrHP+htLkdNQJMxBh+vFMfNWiJ7Ij0EVvbQAe40O6Fd4NcsYeQZgPUJtLQdC
         6NbwHsYq5gisFodWf3SuPudpO8sGI1Tp5AQQGxUu32hgY0GL67Io+dzLK4L4u73w9mou
         tmuS3r42sGPqUpTJ20kM9ObJ2I1XCxRsR0R2QGq42bRyhcNzpuePqtETFdc/Pkv3YIkd
         q1Tf8serZab//+8hdFRsVwngWsfb5ilRQbwR6B1oKyqw82L+t+DnfaQ+u+OCu/D/7rkk
         B4YV8C2vBzazGIBfpT5SJcHGON/qKhcbN0/mERHBjVgBwyaybvCwnRyQLs64yz6zkJTb
         KACQ==
X-Gm-Message-State: AOJu0YziZoMKK5NWUJHjHNTri0fDxmKrr5bSQW5Tz8PthZPNwVLm+tIN
	RxzpPUknqXVZ4DShG7bYQp0t5a5+3M2UwSXxsxUba2IALvCv/fA/5zm/VQW3kNGIR3yKN2ILSYS
	YUoElXgHXfGFpp8lKNXyboZgUv7bojPmH4a6ChnFzX7q1zYVVPJuUgDvsKwmt7Mg=
X-Gm-Gg: ATEYQzzH8kdhTOVp8S1bw4Kl9YLJLPJG7NEsctvau6S65RQOkFlk0d4zjTxp9xi4pCR
	vMqVaXkgR+ZVBAhZM3KyjSq+WatS7eqXooSTZaFRcdvWsRHPQly3f0LiOjM/9l1NrGeSDxupaM3
	HS1hwqNJFziVHin36yLZOjj8Y+SyYh5ChVgk0BlBjyBs+UhkWdJjVxkBvgxIgSSIm22eB6sjWe2
	CUK55N2XFlQr8+2Xz2RdJU5cpce3NERoS1TPGIc7+/eDiXn+G+HVUjPJG8b7WwjAcRLFG0EMlwJ
	Ob7Bf5lvt2MaWEtV7h9d7i2Db8Qik9ArHvyg46AOGTwUj1ZeSWTlzjXhJMZMTaSrwBJ60MhvX68
	ClK5bZxeRMDFUCmnfcbaY7nHPA1ewHD+U7ke1XMFxW2ryKhZ6Iu6N
X-Received: by 2002:a05:6102:c06:b0:600:d0f:bacf with SMTP id ada2fe7eead31-60295c26f91mr7717445137.11.1774279076022;
        Mon, 23 Mar 2026 08:17:56 -0700 (PDT)
X-Received: by 2002:a05:6102:c06:b0:600:d0f:bacf with SMTP id ada2fe7eead31-60295c26f91mr7717424137.11.1774279075565;
        Mon, 23 Mar 2026 08:17:55 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:f9a0:d7e2:7eb6:79b5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bd923sm35936993f8f.12.2026.03.23.08.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 08:17:54 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 16:17:15 +0100
Subject: [PATCH v14 09/12] crypto: qce - Use existing devres APIs in
 devm_qce_dma_request()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-qcom-qce-cmd-descr-v14-9-f323af411274@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2266;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=azGHQ+ypZ4Lhe2NPlFIx77n1JCkKbs9Xx9/yXH7ccEw=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpwVmC3BbPHKUcjTHe5TMiO9yZ10QstnZzV0KUR
 6F5bvI+cXWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCacFZggAKCRAFnS7L/zaE
 w+PoD/4jky+pkIFkSZLdWX+ThdxlM9RmeODxR2zkQT6LI57HgVk3z9BMCHOQ1Pz+OT/TA9CQ9Pa
 hXgiG0yEC9HzAPG/BRj2TrT9xW2Pd3uWJC/YrJ8K6e7+8StGnr4i4blBASj2JACX+3grCEa87ti
 l8QZyxaI1lf9Y/Bdp+Ir5qD6Lb1h36J5hTJpT/ejECOzGNWczCoEC4WR+gtKErgAcAN9uLw1dF6
 kEi8NeSIepc/u0MZzAg8gnbtpE1xbg6DTk4BaoKY1e3u03BP3+k39hy5byPZsYjR+kYrTIc9BHs
 EJIARINSvQXi5b0xbRSRU2aptScYC6NCtpSWErfUnjQKay6CX0/nL1/9QIoLD2VKNKt67Fud60n
 +9ud9d11eAourrQz8CfxHjzcHdjQiyM6QdY9pUhN7vCZmQUrgoK6n2JuNSgkgeiuH+EtIKdY+Hq
 yLZlRPPr7bAIyoy6jvD8Gm4a960+4mhH9mBmGJLXIGhF0fKxgesM+1MR3rCce6C4nVl5ou37pxu
 y/kX3I0mvNVxEPsUOaBNciWbXxzlo/uUK2EWoBcv8ua1U2pQwiNJpWKSNpeG04FEuim21W60srn
 8XgoXRsMXbYEDQX0KHMLCjwltIhidgKB3zY2dSjwTxl5StlU9tp7jJX4m/MOGFQqqobVMylscmi
 yWsF24FWKBVEPnA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=RMC+3oi+ c=1 sm=1 tr=0 ts=69c159a4 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=r78XHnC5kAO70zNBxnsA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: wiGhmYBntvRs7uUh0RZIWeGdid58Mier
X-Proofpoint-GUID: wiGhmYBntvRs7uUh0RZIWeGdid58Mier
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDExOCBTYWx0ZWRfXzr2xT80lkb8K
 ZR4RIWcDa3L1L/j8RBVw5YBTcZavBFqJl7sVehFlvcR85buHGd1vwC6782aTYSlLBC6vK5sidV3
 2y7KgewJHUM7/iargMPHMg4WSJpN01I/EeONOi4meFiF8evVvPXxvOxsCrJvlCnfENrIZKl7hYC
 ZW+JFm3wm2xs9nmjL2O5t+xmQZri5voF6cBpMC7RCcXOlmP1Vs4q/XgmC1SKt3du2qNwGp+3EiP
 x28ZSaL8tP7NX413LeAtaKi+b2gw0D5iF/oUuU62Fwv9cQh0GxAGnqwbCA6XmacXto8qC27zIKQ
 DS/CUC/jPnnOEQlOdSLdgW2+3bjfZ/w3uuvJm791afPZOA8oyWBuvhFY4sWfc9p50E7lz4SKR+t
 Me8ZUpI/x80rMuOOI+iZqJM3Ni1t3L0esQxbiIgiQ/JENA3iq+/VlPoJO/qWi/IbCt62Dml1LHI
 MiAmWwvfEq0qDNrW1lw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230118
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9608-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,linaro.org:email,qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: AA46A2F74EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Switch to devm_kmalloc() and devm_dma_alloc_chan() in
devm_qce_dma_request(). This allows us to drop two labels and shrink the
function.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/dma.c | 39 +++++++++------------------------------
 1 file changed, 9 insertions(+), 30 deletions(-)

diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index c29b0abe9445381a019e0447d30acfd7319d5c1f..a46264735bb895b6199969e83391383ccbbacc5f 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -12,47 +12,26 @@
 
 #define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
 
-static void qce_dma_release(void *data)
-{
-	struct qce_dma_data *dma = data;
-
-	dma_release_channel(dma->txchan);
-	dma_release_channel(dma->rxchan);
-	kfree(dma->result_buf);
-}
-
 int devm_qce_dma_request(struct qce_device *qce)
 {
 	struct qce_dma_data *dma = &qce->dma;
 	struct device *dev = qce->dev;
-	int ret;
 
-	dma->txchan = dma_request_chan(dev, "tx");
+	dma->txchan = devm_dma_request_chan(dev, "tx");
 	if (IS_ERR(dma->txchan))
 		return dev_err_probe(dev, PTR_ERR(dma->txchan),
 				     "Failed to get TX DMA channel\n");
 
-	dma->rxchan = dma_request_chan(dev, "rx");
-	if (IS_ERR(dma->rxchan)) {
-		ret = dev_err_probe(dev, PTR_ERR(dma->rxchan),
-				    "Failed to get RX DMA channel\n");
-		goto error_rx;
-	}
-
-	dma->result_buf = kmalloc(QCE_RESULT_BUF_SZ + QCE_IGNORE_BUF_SZ,
-				  GFP_KERNEL);
-	if (!dma->result_buf) {
-		ret = -ENOMEM;
-		goto error_nomem;
-	}
+	dma->rxchan = devm_dma_request_chan(dev, "rx");
+	if (IS_ERR(dma->rxchan))
+		return dev_err_probe(dev, PTR_ERR(dma->rxchan),
+				     "Failed to get RX DMA channel\n");
 
-	return devm_add_action_or_reset(dev, qce_dma_release, dma);
+	dma->result_buf = devm_kmalloc(dev, QCE_RESULT_BUF_SZ + QCE_IGNORE_BUF_SZ, GFP_KERNEL);
+	if (!dma->result_buf)
+		return -ENOMEM;
 
-error_nomem:
-	dma_release_channel(dma->rxchan);
-error_rx:
-	dma_release_channel(dma->txchan);
-	return ret;
+	return 0;
 }
 
 struct scatterlist *

-- 
2.47.3


