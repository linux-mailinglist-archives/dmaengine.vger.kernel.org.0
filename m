Return-Path: <dmaengine+bounces-12384-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ejHVOSbkVGpqggAAu9opvQ
	(envelope-from <dmaengine+bounces-12384-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:12:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAE874B5EA
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:12:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=C++bvYKo;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=hNLaHypu;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12384-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12384-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 747DB35DF7E1
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 13:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1800D416127;
	Mon, 13 Jul 2026 13:01:55 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8C341CB5C
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:01:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947714; cv=none; b=rZQgJ0gitUM1i8ZLbm8Me/cOZBEmh+sr8/Q0hPKI1chHhD16DZifbVtS6Au52/TQSETe6KF3DnJ6HJgibZO9LLPq6fva/PSWGchlohwPKQiMER+LPCVT0w0vR1LYX/JwmngkXZLRQm62SSI8FmnYiXKTlhvatBL++ZDSWInjWvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947714; c=relaxed/simple;
	bh=vuAef0aUBOeSio60r/pSKcTossm3V61GQJlAyMtLfKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DtmrHnZTEi8SA0V/GMkfWoU0NoqT97SYT+nd5OBBwwH0edGd5ckam7Lo1+nmqMAiamWmLLdSFYYGeiYoG7ND8LKsP14bVkVf0jrqVxHCqMQK+4k5202Gph+gCm+yApnNO0djfBW7bVhBEHwaPCehQ63fXXo9dOFM9YWjJnOM9e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C++bvYKo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hNLaHypu; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCDvH71209957
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ToTIYJiHy5tONa3lc6dWWbGZLTEc7JJCb/cDS7cr/tE=; b=C++bvYKoKA4PWl7z
	Fj9/BoSaXCBYnuw4KX+woJ/i+yg+v7xY+sKp+//LJvvMGIjjIxqwRDB6wqhSMZuo
	eLjIT97Gph/mHA6sWUtUhzbQU2W0NnUTG/jtz/CPXdh9v1y6UAj0IIPfzqK3r6ha
	Dml2jt6/TjwYUxG1S+gasWwylClH7hIkIhbIL7jJkMRQH0bDnsxBZH/8VUkq2NgZ
	XQ/I3TP2rSvZL0s2xLCC9XzKyG0MPv1icVvtjGaKC8RgTJlF5bb+MEIYcnUhs4s4
	RZzMTzfGw9eES+jL/zP+neNSSsSdxErLHfIm8x3LeoYZ8uYJGhIpVunKCPXBheCR
	8SHQDw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcw4qrte9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:01:52 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e9dc0f5900so7412307a34.0
        for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 06:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783947712; x=1784552512; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ToTIYJiHy5tONa3lc6dWWbGZLTEc7JJCb/cDS7cr/tE=;
        b=hNLaHypuslDplWc7Ulnx0KfNsLEu0cOCdn6DY+q9pfcKDw/ac625dY+JBGQAFstH2x
         oLb+/nqGTBUNKtXVD4elAoR4joq9CF7HjWCiMSPGLF7I0Ha7L/t08zKZT90Z9gC9pIfM
         KtIMciey8iVdBAW4lmCZ6h1x0t+3S/BqB9jVlHwIP8iIeuiNP6UJJHulL+9wxUvRaVOy
         PfXS+LOENfTdjEv+Y3ziuugihZ3b8XOxF5msV9Lx+dYYmetzs6k2N86t/QzjdwASHZqd
         NTETux1zEe0v1yMxY1SkGg45UZFl4ZcQENKNoXUGWfWZDtmUAEGwTlMNd6fQ99hhVNUt
         ti3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783947712; x=1784552512;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ToTIYJiHy5tONa3lc6dWWbGZLTEc7JJCb/cDS7cr/tE=;
        b=IfaNbQOyvtXMlZEy37VjP0J6OKO8mEItPo3ytLiXrXyyA78cmef5lb2iXfFzo1HK4T
         YbLlYLtvi4LodugQXDULjd9Y58EtlQWrj2sQO6szxEM85FBTOarw3ZpzjDMGsuVK622W
         BNXofVS1d3O5YzBRT00K6MNhp44htwe8VKYHOVT47PzdEpYqYHlY3O1aZTxo8HnHwkac
         isqhW0HtwAS5C7cFNMhtOnjYJIiyyGVUvf6egqAJ7LrTz/7PQZY1llallAQbxI9Wf49H
         vWrVpCC11AENo/fyAPYlGIIjIhYJZOiz2UkaUawpIpW4Wl46eoJqhhD6WfasL/IYveSx
         j8xA==
X-Gm-Message-State: AOJu0Yx0aW0H0du4+Ew7jTSeGZvx+FuMkPaKnoPtXTpLfQwW8uG3LFuT
	QCKzjXv/qiuf5QQcwqTS7EG0oJZJXLCF85WoRrwzm7DAVK+391jyXZPCh8sqGh34cvEfdzibRfV
	lx5f2dibjFdI2iBuF9/BEd0nmx7B4PK6VKqYba+VnWOp/18RkQAxhYoH5WGPwleo=
X-Gm-Gg: AfdE7cn7D2LFvydC1Lq+zwpOO92YCE44SgV5/0n1meOZ6x4zKVMK8+MYDgod6MUjvgY
	aYMpaCAC9Rm3Hhgao0pNSajXA33IU4oazzd3pQrTCJxb4oH84EHXWrhv6XMDvtW9RMQT8qcVnV0
	4IYt1QY4rr1Hx1g0Nn8HB5VtwDYD/pw5Ci2X1qDar/qoiKsvEC62LWbMlZrK93Dd3pZUaDAOPdN
	Y/eQi+cL2cPqjXVoTCVgh/3I60Qntbsl3zYWhpAlTImfmuxRLWg9laABn8b+qefqF9K/50UVpZQ
	vplahj4Brq36ovwzgQ4KuJW/TexRTs+iHYg4ZJyXuba09VpWw8tyx+/5Me/u8bY3YaJUbnlyuRt
	HMjdG7FBvWUIMHJRBEqhlCeZeHSYAIQo+UYZXz0Ci
X-Received: by 2002:a05:6820:1a0a:b0:6a3:7d5a:1ae0 with SMTP id 006d021491bc7-6a38b9f0c0cmr6902330eaf.29.1783947711611;
        Mon, 13 Jul 2026 06:01:51 -0700 (PDT)
X-Received: by 2002:a05:6820:1a0a:b0:6a3:7d5a:1ae0 with SMTP id 006d021491bc7-6a38b9f0c0cmr6902275eaf.29.1783947711045;
        Mon, 13 Jul 2026 06:01:51 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8881:83b8:89fa:1a2a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2d97527sm306129725e9.2.2026.07.13.06.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:01:49 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:01:09 +0200
Subject: [PATCH v21 08/14] crypto: qce - Include algapi.h in the core.h
 header
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-qcom-qce-cmd-descr-v21-8-bc2583e18475@oss.qualcomm.com>
References: <20260713-qcom-qce-cmd-descr-v21-0-bc2583e18475@oss.qualcomm.com>
In-Reply-To: <20260713-qcom-qce-cmd-descr-v21-0-bc2583e18475@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1305;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=CUp2WTmSuEfCdx1+Ds/evRL1UENxTV/cwxTY1f9GBAU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqVOGdIJMZbD30Ir6MPnqFekcNPq0AjO4fvaXMy
 HuGbWZzdr6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCalThnQAKCRAFnS7L/zaE
 wxivD/93ThfidN7R0lxtpI59l//wvd89SN9EFKqvevdrZmeZUM2n9BNk+0V2zIQ/T75BQQ/4WoK
 5ZMmrneskmHZk00O2+JYrEgdsKna+qpriKe/bGoKg8wPoAC2u/Q/bChbfeisnpJnJ+/bVi0PfiO
 ORlAvQ1g0DCmTfKYWa0t46jTTlivRLUqzZ6kHY5EbciCGV8omxWLlkQLvDOJZrhJDK0aRjRgGl6
 iR7inEOFnjy2WbUB34Nu4NQj/aGtKNs/3gwtkmXqyEz+FlyzZ4niadDM8RcA/4Sz1QzS95SgX6C
 DkhSgZuZSA8ilJDdzP9fE/ZUYWAkJ7/UY5Q3E4n63UgGlRPZJqCVA7v0PZqchnWcn6d36C6tWRW
 jM9eJRbvimDuWPnpUZtp078615VgWGDjrD8W/4XbWARxrl1IYQWtR+ECB65+ekY9fctfEbF5avG
 WK1lvxeXw95NQvdHd118d8o1BLMucX0PHPjz7oj51Rv4c/ZhD9KcufolYQfQ8T4RuHHTjYF6Cuv
 Bx1DA2U+E0jeIpGnIRDte0bm9ou9JYRcNGMPkEO2jG/adpYdbMhf2Fh/V1sgHRp4teFYA+bi20n
 Fmk070j0OyWbe6NEIF33u7HjXVT7WO045hedaI6Ajug85whxWdL91I+PqIoA2DDCJ/JxhBYrE/7
 UZBBDi+BCq4stKA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEzNSBTYWx0ZWRfX0nNpWmiS3U3l
 vsT/+SvLnhPRQYdGnjBIzsv1K9Cdf/WzU7Qh1MpobENFkdvxmWYD4X1rkxUEAQrWQ+omr4jWptz
 o8ejO86MSYuY0G0HeQKdc+togcxt8c6YDMxCzsQMNxODBXLOLjS4iwDsUeJwF2MB3/xhMJp3EOY
 b9cYrZRR+GHvZIHyqbL3obLVFH7aX6KXA5rPVj2iCHXS4j9/NsQpiNKbuzZeJI9Sul+VBOnTvZU
 c3R0bvT/H4ksMXbC0hBp3/Cvg9vkIz4m7DNDsiLZu3GBdP6gK3fqB9/DSn8icFhw6n8wTjYBzrU
 myQJ1HXuB5u9Fim7S+zZ41twMxQIgqXcfe0CmofEop/Tu2ziztJr/BwhojTvlJKwlyeQnMwse52
 eEzWqkHsVBjNa8RQHeydiLPpDtvQi+sbylNiCItCUn0JJJNH+/y74tjUg7H6mSNJ4ed7hFG01aL
 hS8sTBpSTsQSWcw0a+Q==
X-Authority-Analysis: v=2.4 cv=HJrz0Itv c=1 sm=1 tr=0 ts=6a54e1c0 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=KKAkSRfTAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rvG61WhHFVBzVmnuldcA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: jCTUSy6gLRXUmcbRGMDpuHtNk_Yb6fUa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEzNSBTYWx0ZWRfXwnDJbBmSHKuq
 qLRvY7Mu1aYy60Bdg/dknqTyUUajj9DpxZx/QUtMPBMflXIyRjvyL0Tyfvp5II6Z64JdCQn5OT7
 ZwuWnEdgZfFYIBXW4FeF9cNfmFscZrU=
X-Proofpoint-ORIG-GUID: jCTUSy6gLRXUmcbRGMDpuHtNk_Yb6fUa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130135
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12384-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:corbet@lwn.net,m:thara.gopinath@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:quic_utiwari@quicinc.com,m:mdalam@qti.qualcomm.com,m:lumag@kernel.org,m:mani@kernel.org,m:stephan.gerhold@linaro.org,m:andersson@kernel.org,m:peter.ujfalusi@gmail.com,m:michal.simek@amd.com,m:Frank.Li@kernel.org,m:agross@codeaurora.org,m:neil.armstrong@linaro.org,m:dmaengine@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:brgl@kernel.org,m:bartosz.golaszewski@linaro.org,m:bartosz.golaszewski@oss.qualcomm.com,m:tharagopinath@gmail.com,m:peterujfalusi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp,linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6FAE874B5EA

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The header defines a struct embedding struct crypto_queue whose size
needs to be known and which is defined in crypto/algapi.h. Move the
inclusion from core.c to core.h.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/core.c | 1 -
 drivers/crypto/qce/core.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index b52a26ffff5ee733adcf4e8cf8bef75018dfa63e..dd860435d2c47a608c82cc2686583a44ff96c889 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -12,7 +12,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
-#include <crypto/algapi.h>
 #include <crypto/internal/hash.h>
 
 #include "core.h"
diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
index eb6fa7a8b64a81daf9ad5304a3ae4e5e597a70b8..f092ce2d3b04a936a37805c20ac5ba78d8fdd2df 100644
--- a/drivers/crypto/qce/core.h
+++ b/drivers/crypto/qce/core.h
@@ -8,6 +8,7 @@
 
 #include <linux/mutex.h>
 #include <linux/workqueue.h>
+#include <crypto/algapi.h>
 
 #include "dma.h"
 

-- 
2.47.3


