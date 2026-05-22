Return-Path: <dmaengine+bounces-10732-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLxKLxdpEGqgXAYAu9opvQ
	(envelope-from <dmaengine+bounces-10732-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 16:32:55 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FA05B6329
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 16:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8229C3058719
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 13:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B5F43DA26;
	Fri, 22 May 2026 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="No6M8Rjp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EsqWgxlE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EA343CEE3
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779457228; cv=none; b=DKOW5OLIgUHodd8wNtkMrRVyxotW5oKzYmxG0oYiUAJ5VtV/rvCyQb46g9EmMTt7u7Xylg4q1Hn71JjIZhg22CtW+PJ7pE18XLqgDm/zwwrODAun9UEYWxtoAcPPU+Sa3gmXQ5CxyJJ1PFGnklLenjoX/N4zn7XqUNeCn1MKN6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779457228; c=relaxed/simple;
	bh=8kt/r9HrIy2XInrbgvfr96jusMTBkm3qidl31H1ffz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=esLnHh2UduLzYD/1IWQi54Wyta4rahl+MEfyVENMszCWwr1ldVp//V1vP78hpNnFZzXwPENvJUf94pJZ+0h1qb8CgwCL8N2NRuntCxbCu9aIvu//ZtRlHfRHLfCf06a9Yrx3GN5JYmG5e3F9qb6bPRyqNUsQMc97Jq6dN4Xd41g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=No6M8Rjp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EsqWgxlE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M8aT0p399102
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 13:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tEzaODDzYECg7HtqD+MDkUrvvRFJmjC1+RPt1k/O9MY=; b=No6M8RjpytrH+Ej8
	nPxPuBMdxzhYY6j3kJxMz9Qs6FkM1YzdFcOha7sPXPST+aN9pMfAxzn4XjhhKYtv
	tCf5WeivKclkFUQBlZepbztZ0otTM9+ZGcTgGzS0EOPRfPgDva4cUg5o//zTunfV
	2CADJzvneru1kpFX2jINryf+HPy3PvlSFYuQdOaFS3M/lE5uel88UmBoYsH6xo1H
	H68qlK+MkmWqpUGqDaTsRxOZQmA9wFs5Kc6pZ7uomo/I/0nuIcqLXyBiV7tFFqBh
	sAIsmGFSnI9OJOb5n8FTdaG7dN9NyAlP2yWWHT8oAKRHjmzHRWHw55tT3tTxJNxs
	xarMEw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea5p9vgv7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 13:40:25 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-516cde13e8cso33102491cf.1
        for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 06:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779457225; x=1780062025; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tEzaODDzYECg7HtqD+MDkUrvvRFJmjC1+RPt1k/O9MY=;
        b=EsqWgxlE3sVKwpi+NuShfmH8VmFr4RExWdz0uUJ/bAoG4kkuzHWne7oiWcW7IGsjRu
         zcTs+EHJthbh2h8fUW0JUvv1sxPks41DnCF+5VndBlyhmdGxQBi2pOzU92FY+HX+qUuj
         IYPHeNcKiyro5jK7KsQHjnFqci592puHlAzFaJqBlFwMrW2IrP5ia9rBfMd5x7an7oJX
         zQZ80V9L1gJ5b3inZB6McJIIPQFbvnl/NPfY3Tajj3D6q7wwOzfLembujQsrdlhGSwiw
         Ksphci+wY00J40LHmfY1IqaiEnaqhqPEP7tgT0eQz7h408O/GLQcpJFOKXGj3FgYJvqi
         Vjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779457225; x=1780062025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tEzaODDzYECg7HtqD+MDkUrvvRFJmjC1+RPt1k/O9MY=;
        b=R01MvepiTh2fl3CrBRopYMP59DQ3JZv/iQPRU7kIFujC7UOlPRFuxE0cbIjMRlTnk2
         D+YszhMvz5aUYBlyLWM5rSdDl5c0d7y5hdfJv4cDMUTfZC/ZNZvBbh3duwx2ZbhieBPe
         9tlOCVQS8+1sxd1kUWx0g+E4Xrx0xLjsJHhTIdeQp2JurwUE6th1ZtkYzS8eFCQzz0G4
         wyyIDdqjYnp+pDAiE2O+l/63WDJ3AMZuzuoZzfwnXFibM9bLC9Oili2UeU4epNTbf/rf
         arUJBmUqykvZJYgKs1APO85VrP2NPHJ3HCzzPe5/x7YC5CJj3M/bZEy2oou6KJ6+ZSUj
         NIng==
X-Gm-Message-State: AOJu0YwFvWWLsNMjiapyTVf+K+8pPZzv0Sn4gc4qCCOV7Kqp64NfOuWl
	vJ70jRsiYJI818ShJ3Of+A6/RULieZsdSAQtCYaimqL/Gsyp1+ebQC8NuToNUYSIfSs5Y59JRtF
	XK/zyRQr0LfjpYeVgFJMyDVtqkrKOCib61jZytEdpSswXwk5V+0PA2MqIEvRzTQQ=
X-Gm-Gg: Acq92OGHWGwKIR6LcwsUUgca6y2S0KpzG+MbqwxJ9AksA/wInfrECQed8/d/1U2NHo9
	++2+k8yRg63VSjnVxv6plU0O1Z0wWXYs8F1rBWtjcgn8BnwNTiZtp2JLlH3Vj+csn69mKc4itKE
	oJWHGKXxwdtZ9l1yfxqaWZRg7dA3pSlh8fdGUbBU56aGl1hZ9x+0R8Z+psZAsqwH/bicRmiGKPW
	C8yzXjY+cXp6vLUERN24DVJ0mYF9jRbEVKNthOwwYLYPWOQ/EsADfjaRkjbO9Z7nwVqgmDF+yYh
	4Zq06rtMm0LOj6kze7EXMdh8J7tHiUY1m4Eqsdel/k/N9i7aTn5N6uQ0tloaB4YX4vQ6dz4yyXV
	xXCpHAw+rechvux9ClrgUBEI5AWYTYWYbADsqPZq7N2sU2ULR3g==
X-Received: by 2002:ac8:59c8:0:b0:516:d1c9:8c63 with SMTP id d75a77b69052e-516d419a58dmr55277681cf.0.1779457224560;
        Fri, 22 May 2026 06:40:24 -0700 (PDT)
X-Received: by 2002:ac8:59c8:0:b0:516:d1c9:8c63 with SMTP id d75a77b69052e-516d419a58dmr55276951cf.0.1779457224043;
        Fri, 22 May 2026 06:40:24 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:2fa:6280:a48f:fb37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454c600esm44912825e9.3.2026.05.22.06.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 06:40:22 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:39:56 +0200
Subject: [PATCH v18 03/14] dmaengine: qcom: bam_dma: convert tasklet to a
 BH workqueue
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-qcom-qce-cmd-descr-v18-3-99103926bafc@oss.qualcomm.com>
References: <20260522-qcom-qce-cmd-descr-v18-0-99103926bafc@oss.qualcomm.com>
In-Reply-To: <20260522-qcom-qce-cmd-descr-v18-0-99103926bafc@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4421;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=8kt/r9HrIy2XInrbgvfr96jusMTBkm3qidl31H1ffz8=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqEFy0QgoalJd4nsv+KyNxeRwnVz7T7emmA0iAn
 w+bq7A/yZqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCahBctAAKCRAFnS7L/zaE
 w8mtEACcAKWhiKNBPOKaDaJWsMVeL5dSBaURqzzIgwKoPMxvuoftrlvuBf9efXzi/pqWbtaH27k
 zaZ2VYgftBIn3qooLBaL0NYAUIEL0rkJBjRJo8M+OrFTJMRa/zt4/8EMlssPdQ42Z6O9IuYvqXB
 ltpqe+k1ySWpH8rH/jqUymODykLOR+Vh42x0oxLXw0eKowTJCVaLgza1j1In+LZE1gisl3EuPeF
 kX0WWm99riJ5ldQGaKd7GF+DKVF15LNhbVMhQU/wJdzkajj28R7ZppWrDj9HE6UJRUUs1MiFJPG
 uHVZDNMB/GaQ4W0ZGae1S2Lv36kurmV0NGASA1lzZmw3/n9xnNywj/Xc7WqYQ0aAyyuBbIWFG8m
 z4A/vK2REBIoVkpStuaxEV0fV0omG+8va5zkFTPuOaZT/Q/g9SEs4Bo/atbQE6YvngQJx8P+0QY
 Mg7WaYS0gSIHxj7rlXGXWNG8mgA2w/taXG4P/bRXYcDXeWIgTurtwBY6UIq4Tb/YeRn7xxHqvCV
 v9ZBIadNbVG0A2yw+TTYB82HBOPlZKQOnDjG+g6Y76jg0l9df0lzUuDyLLoq2eBHz9+Z+KsKxcl
 B9+cO0gPpUZSV7V7fz83npdvNUp0ZCQo8BrNQiu3DMAhWI8ssB2KQ+SO/69U2QVphTM6bIGp3Ia
 ArAwsHajuC1N1YQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=DKm/JSNb c=1 sm=1 tr=0 ts=6a105cc9 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=u-biHsxzOdRIXVMzAPsA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: SJqdCPE-6Cpb53FRzXwryqkyvzKEbXSY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEzNiBTYWx0ZWRfXzTtkoG/5LGvK
 kctfujkTL2ZjTHaZFvoZ7CFkXVTomey6ZcLwTqi7vk/6tsuHOJPzSwcdaqhXjVYwRdmRpos+oQW
 BkS7Lg2SmZsFWbPo/0/CU8jT79duZgnlhoR21EKQQ/b9X+g+XPwtigjpl+9cnCLUgH35ga4+FDX
 LaAeTs0ynzeoQ5shA/dMvYSdFwu4Y9lHSxD5yzV2yRDYArjeU3V/c4HyldSfEBpmNUTbdNy9Cbd
 QEFcO7KHwrIlWBo8X8HyAECjF9BtR0jb1RYF2C8OYSEz1UEv7QaVBV9Jik6w7z9rESfSUvNgcFx
 I+ggHPnik55wzGYSnXpqAu75iQg8kfixiYGhF4zMfrhtMGb0D3/aEwMYoAj8TAv4VgUIbKxz78D
 nzBo+7R+4HBe1TZKe8fxpTi734jGF5yFPtbwvYb6YCIjeJu7/TFDQ9Sp+xRgnsphn6YerM4LugF
 kFK9KhEUQX664eC3Qjg==
X-Proofpoint-ORIG-GUID: SJqdCPE-6Cpb53FRzXwryqkyvzKEbXSY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220136
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
	TAGGED_FROM(0.00)[bounces-10732-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C0FA05B6329
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
index b3d36ea79984385fe0d05ce56042d3e6e3030c5a..1c62f845ac0b956e311857b93f5b504086662f45 100644
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
@@ -1359,8 +1359,8 @@ static int bam_dma_probe(struct platform_device *pdev)
 err_bam_channel_exit:
 	for (i = 0; i < bdev->num_channels; i++)
 		tasklet_kill(&bdev->channels[i].vc.task);
-err_tasklet_kill:
-	tasklet_kill(&bdev->task);
+err_workqueue_cancel:
+	cancel_work_sync(&bdev->work);
 err_disable_clk:
 	clk_disable_unprepare(bdev->bamclk);
 
@@ -1394,7 +1394,7 @@ static void bam_dma_remove(struct platform_device *pdev)
 			    bdev->channels[i].fifo_phys);
 	}
 
-	tasklet_kill(&bdev->task);
+	cancel_work_sync(&bdev->work);
 
 	clk_disable_unprepare(bdev->bamclk);
 }

-- 
2.47.3


