Return-Path: <dmaengine+bounces-9495-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPN0I/BhuWlsCwIAu9opvQ
	(envelope-from <dmaengine+bounces-9495-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 15:15:12 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A932AB9A6
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 15:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E3C7309E782
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 14:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB533E2741;
	Tue, 17 Mar 2026 14:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="liKAUSj0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CgnbRN2T"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CCA3E1D1A
	for <dmaengine@vger.kernel.org>; Tue, 17 Mar 2026 14:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756334; cv=none; b=r5OtVLGXvW9p9iapMSofLeT6kZnBLH0cdLe98xCI1C17VOEU0hqsCJnwtPwd/DK1aelHmYAhZMpsrBOMYJPADnH3gUefCEwrhoVH/4VbykmRC5EZnmq7ggOPwnCa78rFPXQb+v+xG730C/CI/+bUmoUB/kDWws8KdWarC85iD08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756334; c=relaxed/simple;
	bh=6dN4XjHr+6OQnOzxmGwMll0VZH7PW0q5aNlxk1E5+Hg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O/OnWIbZLkA67SHlE3w+6EyWmspiYIas09IlRCDcVZNXHes5zMGjlwIWMP205RsJCjRhDTJwKhziytA/oVvaoAKj7gUq9RX99mYab+mLwnBY+OXaBvc/8wUy3ixoxJsl4tVHJc2Q2oe3VMFF18NywBqZ86vDp6UEptOs4JGnwIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=liKAUSj0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CgnbRN2T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HAk2Is254384
	for <dmaengine@vger.kernel.org>; Tue, 17 Mar 2026 14:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9iGVNuTYeeAltbq14HNN1Bd2g5XTMHQ/MFj6N7hyZ8I=; b=liKAUSj0fGhwnrdz
	tyZen0SYblevWbWtazQX1DnMSZTXAhXUXUwWWOlmvS4oQBzMlB14rIHZVQE7sFrj
	hD2nrkDFohSZZxM/7a57YJMXtujybwEw6LDfEqSvKZ1GOnVd90Ig5F0/933LjkET
	pOGASoW9ZTP5O9ABV1rETkz2CLAsZiu+nrc1UXSRRucdW/ZE/Jop+EFVFukqYOs4
	3bno5WTqr8pgWVTsdXK6dgluusSOQjPVmkhqdUKoTkBNGRD3vX7L0bJPfKFHQ6/i
	X0J+sGY4k8kqKE/KEEu7NI/eANdT2GjWfS/XyxdGCApfLUTZy9CGW6q9s55QhwPj
	IxHpTQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cy5g8gne4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 17 Mar 2026 14:05:32 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-60276247301so447450137.1
        for <dmaengine@vger.kernel.org>; Tue, 17 Mar 2026 07:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773756332; x=1774361132; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9iGVNuTYeeAltbq14HNN1Bd2g5XTMHQ/MFj6N7hyZ8I=;
        b=CgnbRN2TCD2vm5cSqCx5d0hJGPD04pL36UHgEW4GYCZsKUs+QRrz4KyijFRKy5qIQ9
         5o269+oDYzCOrokR38qLQOEOO5893AZA/YSGtnvVGIIywllY5S9yYHJcbXpOTSo5Uty6
         BV/dx7rgs81xRV7yeieeZ2bthWWzf8XacNYVEGXOTEfWto5yUW5hA1EjvY3OcqA4c7Yg
         q7D6RIR/ciYD7MEAKfQ1lnuYf6sI2azAT3j7GL88+cpVwKuZo4GLrYvTP3RLhEjpKPEG
         5VbBWGWdKKfpM9RFs0zIF33TpU3aZ/P6BUwltqm/HgUf80tdZKiBZsPbBL3FSMFg8g7/
         U/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773756332; x=1774361132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9iGVNuTYeeAltbq14HNN1Bd2g5XTMHQ/MFj6N7hyZ8I=;
        b=m4qp+O62yXRZxHImLBrxAuO3XlMqBwKDpx0sFppwocdm2XfAx2oRT+sC9jaTleIGXN
         S5A1c7P2jaE/EauM77Zl/PYlgC8DVNvCCorf6rsEyvnIjtfjt0bFrPzzd9e3c0kG2KA4
         0a/WckdirkTNifgmD8iJKUKXfnYNMhptwcyS1X55M4fWEIiagVUDmiKeJsXQs3OjWvni
         ZGtu0pDI8kyHHgRbN+bzGf7OCeBRaZrvh47siU0oOSKRoKjm3kQchiYUyWNEsGtc6O9Y
         Rvq16P+jAH+xIq2W0bxTGWI3+M/uW7+BLu8TNnEpvzS6NcEzjarrtGVTaDsDBQZPcRpu
         PZUg==
X-Gm-Message-State: AOJu0YxKtgMYkBC8T601VhZ6z+pEeanyVrwHLJO679it9PEyYYe3z7fY
	T3soStZnB12Dc/rOGKqlKig1ivMAZerS7/xZyPAkLe+vJ0YUGwMBFrAw/jGuWR7nrGjH8sYqxGK
	vuFkl/ypVIcL+1TDagaoUnEKX+/oVtmW/50kmPI+okfCc0SltirhTZhmDy7UFxeE=
X-Gm-Gg: ATEYQzyKrJKc9f0sgdVnQn4YcvYUTQ2lpWtd1b2nyU1m5g5vKBzjc5gyrGjIQbnG+Xz
	3GB3e8SwDqMZ42dpN6jSfq1hYI9odM/p9GoBD7FrWrxC6FslK8CXvw8G6B73UcktgRffzmjCw9W
	UJnOk90PNMDunGBW2BWCFzVwmeYPlV7QnBXRjPqYgl57vUBDEfHUkxNFHSEIjq1UhVVvx+i1Ttc
	QafLYFJqiDkumUZk0M8DCmwYSHbvYUGt0BVD/YrdL3/+YczxqIaZlMpGxHGHtOqMZam27/1CP1n
	P2iWaEqq4qVk1SUyjwGvB6pcLuWd5X0DjAA3Euiz4SGkzLTYki5bJONGuwOn9ZNjf7UF+dXxs6C
	NDFlUjD8qFdk1u1ESs/a3ZcUrBnAGnvioI5QpiEyIvmGIKC87hHUU
X-Received: by 2002:a05:6102:1626:b0:5ff:a34:6ce0 with SMTP id ada2fe7eead31-6020e220116mr6681429137.12.1773756258779;
        Tue, 17 Mar 2026 07:04:18 -0700 (PDT)
X-Received: by 2002:a05:6102:1626:b0:5ff:a34:6ce0 with SMTP id ada2fe7eead31-6020e220116mr6675040137.12.1773756174174;
        Tue, 17 Mar 2026 07:02:54 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:6aa2:dd35:4d6d:8eec])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b4938854csm9359709f8f.34.2026.03.17.07.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 07:02:53 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 15:02:14 +0100
Subject: [PATCH v13 07/12] crypto: qce - Remove unused ignore_buf
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-qcom-qce-cmd-descr-v13-7-0968eb4f8c40@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2012;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=DfH5Bb+Cx5AadRW9+jaH1GcMtyO0VLpMWlVREcJBr7o=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpuV73iujZQ5OmYbLyGhNvpgHfkyjrM4PJIPIUX
 CAKWC4U0W+JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCable9wAKCRAFnS7L/zaE
 w+CkD/46HMPC12W0V4MTUjE7Rk/IgkkBeNhNdo/H3IAMjUsoEi7JvMB4HcgQgD97k+fm29N59JX
 aR46Vp6Z5XGMc8x4qg5SjywfxX/wosezI64FMejNfgWypWlunTqo4Q5EoEcGXQQV3Cn3G2KuReA
 GAkucWdzOyWNm+mhxJW+QTIazutS0Der71WjtfY3DJt7b2ts7IGKqINU+gmNOzUHMfS9tM9G+KG
 ENczoKR1rdTX+tUx5T6MaLirm5YOMZQhMJk5pV+pNjpTdV85MyPoL0n2WEpPaBCtMOzl6amLI8s
 1LmcSKvdKjwBfG4ckHRQGyMv/yi9m30GNWdno0b48+qBe5UG8krkd+c6BXvVP8qXDVEjmB8ljBi
 kjeJvZsANSff142+RajX+M+NnkFB6Feoj9lx6cBwB0EuQHwQF5NFWznzcQmlDvfTfHN1bNl9PfS
 lbSl7ygc2fBRQP0gIMvlrebG6YBL7SirsGgi/2cGmD8rchSa+wISYcGInFSPjQzPAoqkY8qoYc5
 YuVXBzHSRFd2yUJElUxCcgV14jGksbPVLzg2bqXHtNLeZHcjZuYM+b4nWAtNPGWp39XE2SnrYMn
 MIyilz4aIrmfIHg2KbiFLMGIB/yMrCDZ/YpJM2CXwlVynf74wjunpjLAONagl+SW+5JE296iY6I
 igYbF8oUxNjwwWw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: uX7tRW_UWk309l_6V1-9Vm3Dcp9XPHxP
X-Authority-Analysis: v=2.4 cv=EeTFgfmC c=1 sm=1 tr=0 ts=69b95fac cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=tWRRbWwrKX-5tUpmLDIA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: uX7tRW_UWk309l_6V1-9Vm3Dcp9XPHxP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEyNSBTYWx0ZWRfX6xDFj0wI683/
 KC8rqc0rJ+2BS58/u29WMcV+G6Wx3hGXBBSca4ePDv9ThUKlXL6vODFQ/r3If6nt74T9jye0cAs
 9OMMNox85Wk5NR3hi8qMA44UfINrTowoBH/aYfWTFcSX2QRrQGSt4v4MFjCTxwdQ501V/kyuZy3
 uW7plEqbhGFbVsiVd+jmzuzRvV9kpxKBjnlDwoXTxhfAa0X6oYQcyRmuOnmSjI0DPsTfbmds6MM
 6YoYW3qIZKDTNIOV3YQpzoiPHL+B1QmMC7rlkBdhnwXHk32UnJMlvlJI+x4bgOQaQ21jIvSwAhy
 Jng3LqCYZzBwG7PpPXbl964lsD94UodQzVbgzjD72A3YRrBlK97qVWAier7ImD2AsDwi/z5eFxv
 TdHhRjZ3rloj2B7KfquoQhjqz49Z+2CAoV8gVgjaLMHeWCRNBD6RRJnhDHN/9U35cxPwL7d9fcp
 sygWef3Z6glIP1Zk3ug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170125
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9495-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email];
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
X-Rspamd-Queue-Id: 11A932AB9A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

It's unclear what the purpose of this field is. It has been here since
the initial commit but without any explanation. The driver works fine
without it. We still keep allocating more space in the result buffer, we
just don't need to store its address. While at it: move the
QCE_IGNORE_BUF_SZ definition into dma.c as it's not used outside of this
compilation unit.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/dma.c | 4 ++--
 drivers/crypto/qce/dma.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index 68cafd4741ad3d91906d39e817fc7873b028d498..08bf3e8ec12433c1a8ee17003f3487e41b7329e4 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -9,6 +9,8 @@
 
 #include "dma.h"
 
+#define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
+
 static void qce_dma_release(void *data)
 {
 	struct qce_dma_data *dma = data;
@@ -41,8 +43,6 @@ int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma)
 		goto error_nomem;
 	}
 
-	dma->ignore_buf = dma->result_buf + QCE_RESULT_BUF_SZ;
-
 	return devm_add_action_or_reset(dev, qce_dma_release, dma);
 
 error_nomem:
diff --git a/drivers/crypto/qce/dma.h b/drivers/crypto/qce/dma.h
index 31629185000e12242fa07c2cc08b95fcbd5d4b8c..fc337c435cd14917bdfb99febcf9119275afdeba 100644
--- a/drivers/crypto/qce/dma.h
+++ b/drivers/crypto/qce/dma.h
@@ -23,7 +23,6 @@ struct qce_result_dump {
 	u32 status2;
 };
 
-#define QCE_IGNORE_BUF_SZ	(2 * QCE_BAM_BURST_SIZE)
 #define QCE_RESULT_BUF_SZ	\
 		ALIGN(sizeof(struct qce_result_dump), QCE_BAM_BURST_SIZE)
 
@@ -31,7 +30,6 @@ struct qce_dma_data {
 	struct dma_chan *txchan;
 	struct dma_chan *rxchan;
 	struct qce_result_dump *result_buf;
-	void *ignore_buf;
 };
 
 int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma);

-- 
2.47.3


