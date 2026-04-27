Return-Path: <dmaengine+bounces-10128-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBFxIJ0q72n98gAAu9opvQ
	(envelope-from <dmaengine+bounces-10128-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 11:21:33 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 020C646FCD9
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 11:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3208F30451F4
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 09:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D36B3B27E8;
	Mon, 27 Apr 2026 09:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ORXSPtIW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WGwqLeZW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74153B3884
	for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 09:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777281368; cv=none; b=hvp/BjZDrHz4aPc4D6TgHTtP7beLOxCcm8M3fXrmgsakOJhT2D25YkmWxqdoSWnqdn1tg8JarzRDgxHzKR/hsXw1wYSxCIJgbbmJqvUvDDuk0tvZHKlIL4yZwmkjvqiuG9sFDP6zduljBI0vqu42IZ/UQaXHghOxGt48l961lnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777281368; c=relaxed/simple;
	bh=aFvWQ0r/9MeZDMiHp0RHPM2rE3l+aKHR+uxUux2PIyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IiWGYjCxYTUKvVJV2pL2GlcsR3d9XTMzo3DexpWQG8ks5vXobeOMA6XAkK7YDfBgvPBJidUtn/Sk/cqKckAHl5yacLCjR8GoxNDUL+40MPcvGvkh5NJvWTqN6iwCufavsoKUQ1h3vsokQq2SssFmEaR2IqLwck6PS4BmZh0CH2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ORXSPtIW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WGwqLeZW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R8kLbq3962022
	for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 09:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j+gmvqmnx6Mc+rqdGbk0x4TnThgU7BC6K13sY2POFME=; b=ORXSPtIWxJV7IuuJ
	/RRTnqugcNIN6TfABsZ0eTWgz1GdCVAMpekbsDv2QMnobomjUyUhOqTRo38nNjIn
	Pm2AvdMdZOd7meNsxahcKAKq1Xm0OCa4MgrNG72038cAsIYxOyLmz6tPMtf1ahJU
	2+HLizCcSglVxJtqJ2AjmqIhxm+V7h7Rwo/7JhS0SWShf8DE7E1gGdhIv9aj94sw
	qEXzGUo9asd3/GcoANP1u/tar1ntkgdklHXi2AWaBoT5LB/7PUaoWNq6w3E2pbqJ
	elAfu1/hnCl7EQjww8TQCbA2P8bzRR+cBuEbsswN6AqiA/KF0d/c3gf8k2JZTz/S
	Yje/Dg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt4k309mh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 09:16:06 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50fae95c82cso175526761cf.2
        for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 02:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777281365; x=1777886165; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+gmvqmnx6Mc+rqdGbk0x4TnThgU7BC6K13sY2POFME=;
        b=WGwqLeZWcP7wXbjRYRy11AsCRE3w7RrrsQT9NwYonS3tMlb50z7JeEOhYvdB65UyO+
         oHW+/6mukQVHSVtj46I+GvaODLXvy8uKAkFhDZdU0PX9eZSht+xrrMzXohqoPXsUtmiz
         FCBYuXvf04bTxeG4FE6F1gx/PYFbPQE0X919zMkYDrQGZFI9V6yF/9gyaNV3tWNFMotW
         r65zLAGh5L7QWCEW9gv+tX2/sQL0Hb50ezg0qIXx26r9N8TgfQjN6kwkM0Q3XLU61+6t
         aZdR0yIwLQFpd4ZAEgX8oW4yTAqH7lBrGVP7mcaFC9BD6pON+lmNuWuf/wOtr0uL8SSx
         zsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777281365; x=1777886165;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j+gmvqmnx6Mc+rqdGbk0x4TnThgU7BC6K13sY2POFME=;
        b=fFZDnhK9qqKtQT7HbCDCowg/eB3E/tOwhAsVGS+LjGUu7zXudwdwtoj4h1dwrVZQh4
         KUDXKM8pPr2Ym53meRvN+KOMer7Zv3w54BE3mX+pK9rxPvjL9qXzlP1zl9/l71ZKe1Q6
         /PuP5v4S3n/eoyxVYOGKhy82ZH7yvkiwlOCLcVxwGsg7dOeozd5yt71qNP2EFnNj7qo3
         NCCZNW37muFAAACzOFQYKQ0YHoo3DbGf3nhNN9w35bmLyG/ecSDhK1HDhBO86gy5HdnK
         /cbxwY5wwVRlDiqu6Mk0+PGFYoqfcSxyN4oN25R1w1foFYeMRvQUG1/2g5CYqK+9Rj1K
         vENQ==
X-Gm-Message-State: AOJu0Yyo+1KCF9bCxG78pznTOX6FBQIfqddgU47FTzCCeElTtfBFQ4It
	MTXc+LUIXlSVi5EkxNKBUqGXF2Kcnlf0lvbXYaGOwPLqXOpQxYQ12O1vgy/6jK0eAXxBpAiXa1J
	fTWvRh8xZ6Pv5Nh2CWkRzBuLSoeeMq1zuDHxzjc2W0LVLHnAdBV8wzF+htWoHVII=
X-Gm-Gg: AeBDieuhQdw9VJS2FvOirEtVLeEnZfQgM3Qb8QzSLedJJMFKKW6Sqiv/LC87VyEvS4z
	IkJVdLXj/iw8Ig7ugTiMcrpLgJfG9FddKnWTwHhXj2vL44SQkUX6oAUeqzBh0w2cZIhnx+imyxn
	OPWH6mZEVKGSg3yoHMN0jkOh4O4Sp7kl3GmEqaiPbQIcB3w8Z41uDFilZ3fI+rQBsSIqOujAZlw
	q1ceXWWg/mkXn9WW0phvuJ31mkTVge6rb/ekfUdvN8yPnC1OIFn8DBEe0P62vFGsDkRs5plNsmt
	rDUTGZAZeHiRk0pc7PAALGDeKUpRLbzas9o4zm1b8juWgsAPwrBX/0sv9tyyg2iENcsIqk6IMOf
	zOC0atbDrj0/jDeAEPVfbwz5/+a78d07uuTXtOQqfnMJis4uj+Vbpaqk90UMy2Q==
X-Received: by 2002:a05:622a:5a0d:b0:50d:6baa:9e8c with SMTP id d75a77b69052e-50e36827a5emr609405401cf.12.1777281365154;
        Mon, 27 Apr 2026 02:16:05 -0700 (PDT)
X-Received: by 2002:a05:622a:5a0d:b0:50d:6baa:9e8c with SMTP id d75a77b69052e-50e36827a5emr609405011cf.12.1777281364712;
        Mon, 27 Apr 2026 02:16:04 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:5062:ae86:23aa:702c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a6dbfd4b5sm40559365e9.28.2026.04.27.02.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 02:16:03 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 11:15:37 +0200
Subject: [PATCH v16 04/12] dmaengine: qcom: bam_dma: Add
 pipe_lock_supported flag support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-qcom-qce-cmd-descr-v16-4-945fd1cafbbc@oss.qualcomm.com>
References: <20260427-qcom-qce-cmd-descr-v16-0-945fd1cafbbc@oss.qualcomm.com>
In-Reply-To: <20260427-qcom-qce-cmd-descr-v16-0-945fd1cafbbc@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1476;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=EVDb1irXK/80h7Y6DY4Kfs/+E6/12M9d/9hBrF4TLTs=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBp7ylANBJgsPFoqyh8BK2lOX3d/GhX6IZh5Fnni
 RkwFP5Yyc+JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCae8pQAAKCRAFnS7L/zaE
 w0qLD/9vNJV15ERL/9ppPG0E99fiIcwIaLtLXqsMIq4NvWtdsmtkMHAwukRVXIx38tz1piI1hzk
 7Wm4eTe6kHd+9of+2g655fstzBkPxb6w8ra10bE54ed03ePaaaIJL1GjSkwZ0Gq36ETnXQbSAp1
 xD1O4zbz25K45kiu3pSH31JhLAncNo+kY5xPK5k1BPFoHSvJSol4+eb9NH/bWf0wdRxjQXlX/4q
 DJcRTib3kaVCabGNdM7nwzLm8MFqGn3cECYDh4JIovIbEPjyezqeXNYLa81zAsD08E90wCSQe2N
 mZFA1+Ad660XMnd1RTSxBqJ8P8fG9MxSWuNIRlCO4V5VK7YN1zeUFVBvc37LYVlgCp1AooMqyRn
 V91Bwx9eytmDvVeLTMj+T97f1uyfhnBTfhdUhehFoMrHF1AlVU0PRqfGlJPDa0crQHD/q1DEXWb
 Uj86aAQaNZJqxLKJ5Fnm8sG13xa2LePKEO8LF/9V4rxItDbXhCTa0Yjwa9FLfY/RSS3idqULspX
 4P2zkwtPOGkmBzw1XY0uA8wLa3LJgPCo+tarAA9O4FqhXgNd1Duh3iRPELSXuLNl5dxqwa6Tc9Y
 U8TL6Wn7Q2/BQi/ISa7NDRIcktBGqEMLVoBmVpmLea8W/AM41PC1IXAwNm1UD9+D0qEjZxoCDJJ
 5u1Ei6vYPi1Qj4g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA5OCBTYWx0ZWRfX5e2fMoH8WZ/E
 awNqswX/4OOW1hJMrKs68W+J+W+isvheh/GmPBbuzqURk4Onr6hXxAovB5S/D7U4XalEWy23NP3
 4bPhXbSIkEmgFzHL1v7efiXp9sfTGH+7yoiWoaQzyIJcQmEhSW4Dbfey3PRYpCt7k1qE7H536R0
 7IwS4b1BuQd5CNSqtjnFBiS/AS0jNyoivUqKfGQAsoKwDPS/lyi3cQNBOP0Bfnp1NFmSQbj9lT3
 KZ2XzmYNXcuhcAMdjmq2GrQeOqVjhfCSL9fIi4oMJhbAzHGfZMZPSXuB5vR7h6YxevL2Jv93Hpi
 TBcXhQDdPhkR/Dzgd6ibPe9+ZFzvyTncUUWEN0COWCXfoeBsQ9Dpl5HKyW8CtpBfg5EdcRpLNDX
 McXpeGfYTT3kDkCzvJbq7JqIY07npDwdK18D0oargrKRncEFicg+IhhQCcH0TLVSjl2Z/3+meIm
 1J/i2GU8oca2iQrKNzw==
X-Authority-Analysis: v=2.4 cv=a7QAM0SF c=1 sm=1 tr=0 ts=69ef2956 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=ZSnkYuKn9ZpO9KHknGoA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 5itTVS6C4_gYYp9Hma2zMzByHGqDvc9T
X-Proofpoint-ORIG-GUID: 5itTVS6C4_gYYp9Hma2zMzByHGqDvc9T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270098
X-Rspamd-Queue-Id: 020C646FCD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10128-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
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

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Extend the device match data with a flag indicating whether the IP
supports the BAM lock/unlock feature. Set it to true on BAM IP versions
1.4.0 and above.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/dma/qcom/bam_dma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 8f6d03f6c673b57ed13aeca6c8331c71596d077b..83491e7c2f17d8c9d12a1a055baea7e3a0a75a53 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -115,6 +115,7 @@ struct reg_offset_data {
 
 struct bam_device_data {
 	const struct reg_offset_data *reg_info;
+	bool pipe_lock_supported;
 };
 
 static const struct reg_offset_data bam_v1_3_reg_info[] = {
@@ -181,6 +182,7 @@ static const struct reg_offset_data bam_v1_4_reg_info[] = {
 
 static const struct bam_device_data bam_v1_4_data = {
 	.reg_info = bam_v1_4_reg_info,
+	.pipe_lock_supported = true,
 };
 
 static const struct reg_offset_data bam_v1_7_reg_info[] = {
@@ -214,6 +216,7 @@ static const struct reg_offset_data bam_v1_7_reg_info[] = {
 
 static const struct bam_device_data bam_v1_7_data = {
 	.reg_info = bam_v1_7_reg_info,
+	.pipe_lock_supported = true,
 };
 
 /* BAM CTRL */

-- 
2.47.3


