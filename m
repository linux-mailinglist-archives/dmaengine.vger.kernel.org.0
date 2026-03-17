Return-Path: <dmaengine+bounces-9493-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IqcDcZguWlsCwIAu9opvQ
	(envelope-from <dmaengine+bounces-9493-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 15:10:14 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7792AB83F
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 15:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52A4B30CF677
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 14:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2D33E3C5D;
	Tue, 17 Mar 2026 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PeSQpoHg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="URMI0mwF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489523E3141
	for <dmaengine@vger.kernel.org>; Tue, 17 Mar 2026 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756192; cv=none; b=F7qG9EHIsGqdbZmvtkUpSh4juOit1twzfqQUf+7ZC1DBE4TyKAK0SrKUa519AME7ODOtfXqfjo2WqqixFRhNTNA/Ws5puuVmJuX1eS7hEmpVEVPTwzvfGF72gxCPAyFrhe0GDuEnk1T554Jiu6vEGLAe1VZ51Jz/f7m3aGTSUUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756192; c=relaxed/simple;
	bh=zaDjliGI9P8SDSmb8oK5ZUowNY4iBaNue5t3+i0OgLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aEm9qeUGJhJNgje+gtWoUA88GtlA9iO7NIUP9sRsHPA3hm5CSvZt8pmzHL50+7LmKXJa6SRrwgehMcJ1y7rRs37R8CVY9VYXtbdFV6RvBG7mqO3IocNhwsGs3Zawdo5d/rakonq821LlnHEVE+DKIuL1Q2CYwuq5DxkY94lzDj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PeSQpoHg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=URMI0mwF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HAju6G254208
	for <dmaengine@vger.kernel.org>; Tue, 17 Mar 2026 14:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nLZDYW56A6RoHAFTzDl5i+KhZW9amsZPLqs+n6djD5w=; b=PeSQpoHgCjkDtOpF
	8xeOshEXMg4ZlauTggV9b9YBkoEKe37XcZ7EeVFd/6tJwGqKWol2ScLNk2xdEIIH
	pyNAokq1UBmH9GFMeu6/KCBbWHi6rNnL7LCpkQ00mfwYZ1CExBcuZQPmMjBfMRvs
	icqFAgUoODE6b54sozyN/12caC4wKLjRwY/4GTbHSfd3fV4X3AzYPnyCdsW9UhDp
	Ex6li41eEdPpTmbuMZ4WoqjKp5PpS65MMZn8n8TKwf10CwonYHW18kt0ruC+MXNi
	ulqV0wv09KEQjXCUTsSooU/lDfRAwrdfg11TO7ppTTVxRmtm3qT0SjFbG9IhOlNG
	z+hHMw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cy5g8gn0n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 17 Mar 2026 14:03:09 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5ffcb3a10f8so6120234137.1
        for <dmaengine@vger.kernel.org>; Tue, 17 Mar 2026 07:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773756189; x=1774360989; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLZDYW56A6RoHAFTzDl5i+KhZW9amsZPLqs+n6djD5w=;
        b=URMI0mwFwDEpxpopfCcwIsWavMqIoeAsgNrcW4hDkpcaiQSPND7pkhqzBNuym8qhW3
         WovjvrJozhovlweAoe190Llow/qqIrJwLPuuJcGRbcfDlX+CWzPFZljwo1hP94dWWsrK
         rdwicwVtsYenh9EZgEjBtnoYSd/R34YICwsZiS1zclSsviAJYkVZ+kcuHC+f4u6A89jz
         YgF4ihFLWooGXm2yvsZXeyhV8NRnvm6XvqiBzSj5ZRMXZcjtJtyIY+6tJFEJ9tfjjSuU
         etKrp+4Ew2iYZ7BOCTLrUBqfaeN+5RIbuDVC3KPUIx03A7ShkXAqb3EZZxCuvoUf15uN
         ltxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773756189; x=1774360989;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nLZDYW56A6RoHAFTzDl5i+KhZW9amsZPLqs+n6djD5w=;
        b=FqDDDdMYJd49garutDB97/C8t5V5T2zy69Zh754zgZ3ObKXJQ9rjj1gxS2TbKsbecL
         zTTyKrIBg1LpJRZNRvCLtZYP1EDPXF6KwWqYfKzAIH0PXEH4GqZN1B5NNWaS/iHiLgQA
         K+Pbkr1H1U9VnDvG1DSLjsc+cFWTennJoPURky+rcyIzH+66GuMo42BOB7wWw5WEyr59
         BIfTAL18SQm46lOgIOjtFtKMdidMTQ5Zb8ofk4JZ8v+8AQXT+ZzQnsUFS4fEY3G+BONH
         IqCa4S60fMH8TDT2gzedLC7Q5gvC9wSAWd9kzDNjlWCEWgxYMxz+fFX3goPZuAWJuRkB
         0Raw==
X-Gm-Message-State: AOJu0YwUe3PsE6ugXjXb5U++MudwNZFKExTOd6WAratoy1n7yVTWK7fj
	Y0iVSILm2KgtYSZ/0wzSmAQlC2QkffddhDHSJ9lKby0QCZ6Hyhff3g3VqtgHwxrzBTaHmvNxT4J
	d5Uym7ytbzWP6EN83o9qbfDGOFKLca0E+8ELfbjRUdqp4/alIfAjSdItwtpYGcXQ=
X-Gm-Gg: ATEYQzxb2UBG1ENF5PKoq26lhifbNQsqusCy9Urv17JIcSyFxzxXwTt0Iwyx3Yf1qFe
	IPB0FHf8EDnr1CvgHOvUhpj1O8lBc7aA8xEHT80dpPBDmCNsn9YU+hIuKQcugAANbO6p7pkr4+z
	ZVfz7dHsGISSx/MMePinyFdmIWWy5QkLqf4Zsk/l3NgilZgh9DG9jiG6CGOD8C2LxDlOieI8RVo
	4W6okp8VQwglA4D/l9WszREUDt3bghaK8tZQtygF6QAq9xlTEeY1n5K4zLCVFXRe5QsOt9pjG4E
	C5ZlBOA+yB2CT6Kc68W3jyyv/Tn6a/E7Hxcx3j/YoCSXweVj64j8RbT+Tv38yG6EB75c6eZnFFR
	sw3TDVKYbcC1gBgqTfePEAs1fNsEiZzrh8eebZ1oBcKvu/s4E1dW1
X-Received: by 2002:a05:6102:3e94:b0:5ff:befc:6769 with SMTP id ada2fe7eead31-6020e501571mr7432157137.19.1773756188457;
        Tue, 17 Mar 2026 07:03:08 -0700 (PDT)
X-Received: by 2002:a05:6102:3e94:b0:5ff:befc:6769 with SMTP id ada2fe7eead31-6020e501571mr7432059137.19.1773756187757;
        Tue, 17 Mar 2026 07:03:07 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:6aa2:dd35:4d6d:8eec])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b4938854csm9359709f8f.34.2026.03.17.07.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 07:03:06 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 15:02:19 +0100
Subject: [PATCH v13 12/12] crypto: qce - Communicate the base physical
 address to the dmaengine
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-qcom-qce-cmd-descr-v13-12-0968eb4f8c40@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2392;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=zaDjliGI9P8SDSmb8oK5ZUowNY4iBaNue5t3+i0OgLI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpuV77vDCIAYQfI0C3VRl7ukLCKUCkcp4kTAmRc
 iM8NiplJyGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCable+wAKCRAFnS7L/zaE
 wxoDD/0WSHRC6PfNqAmPMsnjMbE0sIR5179rvqrjPAs4tHYZjlfgSKp93rEdS4eNLqf3JrBuB3C
 tDP+ethl4+iQ1U/zNVHVLX0UoL6dd+kelGmj16HABRYfZE8OAww7gsCqgt+i/VuPJC1FvAtmXmC
 GdJBFhKm6ln6wNIiyYHEaGXbLCbrJAtSBQQ4s1ehX4guY2rrDaqrIzmdR7FYxzLRZKcHc4GrJ6F
 epJsJcM9LsAAp7UI5gUjq/OwYPZKCtmKp0A7sS6AUZAj/0vsOY3ery5R1rG69LOCBQMvyYjWefu
 jkn5BT6zjy6cyV3O98r2EqReK63cX0ybe5VlsUqhLynoFZUfeJD8aRIdnamKhjBxW/BpzcmP+1Z
 dJadF7bph5q5ZQWll4GvPeeR4bWR6fpE7CIejftDYidq3NDLDSofdlkKkiw3wMLxvYzJMO4hMT6
 DqrmG+lHvPf+R85RPdBBclZ2/05xpRXVT8xCDmnW3VrkxHUOROXBacLS3kXbP2gPz66VydFUzKF
 tsbaqFJ+nYrKJvbRRN7KYnx2xWUXgHdF+1ltnt/KTrPykMf6z89/PtWtJLQ0mDuwsBPZDpU7io2
 GmDJEP7kGuvldOvDCahNhdcmw8iTOnre/lQ8zI3aUM7sUmA/3hTfTGtX1A1DyqgSZEI3YJR2SlM
 rGyUPdHOIWTH8Sg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: XqxQYszVrk6PEX5Hm5AZnbsc4PM2YBXq
X-Authority-Analysis: v=2.4 cv=EeTFgfmC c=1 sm=1 tr=0 ts=69b95f1d cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=6g4OycmRf1yXlxMorl0A:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: XqxQYszVrk6PEX5Hm5AZnbsc4PM2YBXq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEyNCBTYWx0ZWRfX8ZZC7lWxYm7e
 WYZUp1ZoCCbrh1qYT84vDLektmyU81CeEgOyq5KlA1GdLG0lRaqBiWgKbEZJS8eWrvzBRH2Cdh1
 MFQzCkJx01P9wgaN5eVD9cK+dAbY7zEjGCIkzMGEDVNF29MBCEqeGwuiPc2ohBXC5WLxUwetwPP
 b4N5SG6o5ox2RHGok1eQHN2erUOuSz3nfPC5SQR5BNqox4SbZRyrHExolpVXj6IBiVgdagSbUms
 f4bCFJePWB5/ps1alhYbYsAKxzl98lWPW3OeyAySH2MJj6zHbmkr9KAytwHcZpNmFO11cVfjMkl
 e6nNl1ZNP88x4TcbDsLFc5csqDa5hc/6yGSJMJyjGKPtfEAfyDdgdOKOg6vYVROmYpcZSUkk+Kg
 xpj4mYT6m46YrSCzoGBbALqXXjMwwjEGAc9eSNePdiTDbtj6usu/vWwNo2xSLJ9G2xs4kq+jTcC
 2+aQLgJk2/PzaJTvfRA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170124
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9493-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
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
X-Rspamd-Queue-Id: AC7792AB83F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In order to communicate to the BAM DMA engine which address should be
used as a scratchpad for dummy writes related to BAM pipe locking,
fill out and attach the provided metadata struct to the descriptor as
well as mark the RX channel as such using the slave config struct.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/dma.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index 5c42fc7ddf01e11a6562d272ba7c90c906e0e312..635208947668667765e6accf9ef02100746c0f9a 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -11,6 +11,7 @@
 
 #include "core.h"
 #include "dma.h"
+#include "regs-v5.h"
 
 #define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
 #define QCE_BAM_CMD_SGL_SIZE		128
@@ -43,6 +44,7 @@ void qce_clear_bam_transaction(struct qce_device *qce)
 
 int qce_submit_cmd_desc(struct qce_device *qce)
 {
+	struct bam_desc_metadata meta = { .scratchpad_addr = qce->base_phys + REG_VERSION };
 	struct qce_desc_info *qce_desc = qce->dma.bam_txn->desc;
 	struct qce_bam_transaction *bam_txn = qce->dma.bam_txn;
 	struct dma_async_tx_descriptor *dma_desc;
@@ -64,6 +66,12 @@ int qce_submit_cmd_desc(struct qce_device *qce)
 		return -ENOMEM;
 	}
 
+	ret = dmaengine_desc_attach_metadata(dma_desc, &meta, 0);
+	if (ret) {
+		dma_unmap_sg(qce->dev, bam_txn->wr_sgl, bam_txn->wr_sgl_cnt, DMA_TO_DEVICE);
+		return ret;
+	}
+
 	qce_desc->dma_desc = dma_desc;
 	cookie = dmaengine_submit(qce_desc->dma_desc);
 
@@ -107,7 +115,9 @@ void qce_write_dma(struct qce_device *qce, unsigned int offset, u32 val)
 int devm_qce_dma_request(struct qce_device *qce)
 {
 	struct qce_dma_data *dma = &qce->dma;
+	struct dma_slave_config cfg = { };
 	struct device *dev = qce->dev;
+	int ret;
 
 	dma->txchan = devm_dma_request_chan(dev, "tx");
 	if (IS_ERR(dma->txchan))
@@ -119,6 +129,11 @@ int devm_qce_dma_request(struct qce_device *qce)
 		return dev_err_probe(dev, PTR_ERR(dma->rxchan),
 				     "Failed to get RX DMA channel\n");
 
+	cfg.direction = DMA_MEM_TO_DEV;
+	ret = dmaengine_slave_config(dma->rxchan, &cfg);
+	if (ret)
+		return ret;
+
 	dma->result_buf = devm_kmalloc(dev, QCE_RESULT_BUF_SZ + QCE_IGNORE_BUF_SZ, GFP_KERNEL);
 	if (!dma->result_buf)
 		return -ENOMEM;

-- 
2.47.3


