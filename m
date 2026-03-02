Return-Path: <dmaengine+bounces-9186-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HF6Aim2pWkiFQAAu9opvQ
	(envelope-from <dmaengine+bounces-9186-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 17:09:13 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A441DC6A7
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 17:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E07E931CE93C
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 16:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CD042DFF7;
	Mon,  2 Mar 2026 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pQ1cF/MH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fEFjOI5Z"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CB2429839
	for <dmaengine@vger.kernel.org>; Mon,  2 Mar 2026 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772467081; cv=none; b=sRBjGJlpRuLYLylC9lnij4zf+f3MFdHb9hlQ9nz8MfsBgrXvzgmcY/B/cGKI4hp/CWsRq+8IODggN29x68ImY08H1FP88enk/SvpUbeVhqmKrnAedIgX99JtKHI2E3M8UWVL+eOFhUT/21ny2rRKHchZpWKj3Y+X7ZRP8zLry+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772467081; c=relaxed/simple;
	bh=QtDKw3sIoTdfDtZw65i+I58veFyHFSLP2ujI82KTTCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sEGQDptfHjJjZVsSux/tmZWEbWiCcwyZxEP2rHHIa6YKTkdjnZ8h/H62+nMpewFxtZI5tqVLGvwDMElGWdUV+1lxZSZk/hcx1Gn5Py5qNGqs9tmvG9XrLXuG+ug+KuersIkCTwiZSXsUaP/2qNyccs1UAb0WMdTuTQP5UdWmBgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pQ1cF/MH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fEFjOI5Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622B4MHt3561536
	for <dmaengine@vger.kernel.org>; Mon, 2 Mar 2026 15:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AJf/VHFbEfrJ7fM8DpDhu22yxXg6EYy+KGz73+G0kyo=; b=pQ1cF/MHYq59woRz
	oPrTjawyd36QiltIrv43pzT61p3G2qkYzR/zqYARzavBpUevniNAZXa1EVozR2PE
	RbUaTpzJdtRHFOP7mHtMmZl9GdOAPUGNnztZJOdUxGIf7ppNfPUR85fQhI6nAoj+
	hfkbZuQG4T3Zhd3V422sOQwPkHm+lkLJRudA8Ar4m8of5apM7xIz6yzQB2vJBhZX
	vBjN5x/zBYjil+QO42LFEWpPtdaurRGUCpecBMuk7EPEg/QD+/NGvvzDErfDwP1b
	lgJ2351XzPs7Uv+UQpq+SIPjiwBGb3Kk22wy3j8vJod/lMMA/RYfgM9B5WTv0Vgg
	bRJXGw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn9bv8yep-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 02 Mar 2026 15:57:58 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb4d191ef1so561745485a.0
        for <dmaengine@vger.kernel.org>; Mon, 02 Mar 2026 07:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772467078; x=1773071878; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AJf/VHFbEfrJ7fM8DpDhu22yxXg6EYy+KGz73+G0kyo=;
        b=fEFjOI5ZZfVUrHIQrBzM85/ZrTaxhh2J5tXIDhSdscNRCOoXgIxJmGI/ysz6hjnsD0
         wcc/A08cFwk5h2zGgGDMNyPEHk7og5m6PanyS2lHaGB2xRL+nPi+Dj9GHpCDvF7H9EjA
         nicOEA6OF8KrkDRUhZ/Pz7SfORh5+JbwmDWnYvn5By/GhzIUCB/ifsWsfOMrwGNxayGW
         ulF2W9DldLTbCvs791djKjFdKfd29xI0GFl8dxlGGgiy+gWgV2tRzC+RSSyYKdb8iGtJ
         dQe/9IoHavkdJ1MeM4ySWLnAPWhpK1NHVJk73zCaNlrqePLLsvxEmLZkDRzNitrOog+l
         mXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772467078; x=1773071878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AJf/VHFbEfrJ7fM8DpDhu22yxXg6EYy+KGz73+G0kyo=;
        b=D10hdzZAnND6AjgmZSk0W31NteOD57btFiIgB6gl48sViAQ4Et6UcwXk91e+r5a7vh
         WKHidQySffBLol+NLBhT5EW5OBtV/r4JZbJMJZLRvVJkUTDKHTP9CgRf3j24e+BaI2wD
         E3+ZDSHFdNgCXHqjSGpV8cDHGcxQkE/nZx9P2meNE9x0yRdb45PjugAxVhj76AgdaHgA
         CnrmtFYm4rj16oTWx/UE8KOVyuOP1tfs7m0RiNYKKUrn/y/5D5LsBWrLEsvAAkKNp5vN
         3bASjeq7icuZHp8ocnVNue7I3rlv+sr8FtcV6sPAfv9rU0T8FjQWqW+whRfG/XTVXSn/
         pflQ==
X-Gm-Message-State: AOJu0YztUM3vzBZ9F5BJ6F0mCz84XFXXkLgODNthI/VuWEpQVnKpw4oR
	K/OeXOpCcXRbZu9bAMgw7Xj7Jrf3u/3gKiXPuzCBqDAX9yR7/W5GXeG53ZUC8ZOWHPQ87ViUK8X
	b84RV8+9Mbnl8qLOpbCR/ek3vU9OGcAS0zsSwfg99k871U5UIoC6bfD4SOYb3BVE=
X-Gm-Gg: ATEYQzwj2pXJbIMYKlaIwQP5phC/M+xSQYnUw2+e3Fk6xK10dlZMIdhUrcUn6EK6cQs
	U3fSRKT4b1tbyaZAL8WlqK10XBr51ph4txAbwDclbGXzdvgcZmNrTE6CzS98H5KtFUTlqKb5/xV
	e93k3aIt5yqK40fZ2iPlXiFoD5+dnm/3RwWjEyCIIhNKgSuRGFjMwXhbJiJZrDKlBVwLchTMpjJ
	tMenW24/zQ1wLQmrEFt/eoNPC6rPEFmsK9ceDTKJOLg5p7Ya2NytWohnn9AaJSjKGnW1u7y5JzD
	Ql6o6NnJi5sAoeqyiERM1+ZZzcFm2Ru4AtVwY48IetYJ2Gsmr09jNsG3dbfxaUcuarf7ZOE7G1C
	03/i2rYXCaLSpd6by+zp6oWGVbUrf0uL17VOaW3shCSy79eMZRuiR
X-Received: by 2002:a05:620a:404d:b0:8ca:2baa:774 with SMTP id af79cd13be357-8cbc8e82641mr1612982485a.18.1772467078411;
        Mon, 02 Mar 2026 07:57:58 -0800 (PST)
X-Received: by 2002:a05:620a:404d:b0:8ca:2baa:774 with SMTP id af79cd13be357-8cbc8e82641mr1612979485a.18.1772467077944;
        Mon, 02 Mar 2026 07:57:57 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:87af:7e67:1864:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b41831easm11282438f8f.12.2026.03.02.07.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:57:57 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 02 Mar 2026 16:57:24 +0100
Subject: [PATCH RFC v11 11/12] dmaengine: qcom: bam_dma: Add
 pipe_lock_supported flag support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-qcom-qce-cmd-descr-v11-11-4bf1f5db4802@oss.qualcomm.com>
References: <20260302-qcom-qce-cmd-descr-v11-0-4bf1f5db4802@oss.qualcomm.com>
In-Reply-To: <20260302-qcom-qce-cmd-descr-v11-0-4bf1f5db4802@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Tiwari <quic_utiwari@quicinc.com>,
        Daniel Perez-Zoghbi <dperezzo@quicinc.com>,
        Md Sadre Alam <mdalam@qti.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        brgl@kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1425;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=gfl+Fn+ISpyM/izQ226zR5pAGJiHs0gWIagW7nCmNI0=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBppbNt5bDUkL7J/F9xgZHxua3RHn7yN37DQAd5k
 a81DXZBCUmJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaaWzbQAKCRAFnS7L/zaE
 w1AsD/0dIvkbcuCLSVavXlzNy2A5vtB4RVHS7Sh8XU1wqW/rudIXRcE6A/tT6zQwwRl9FKk72R4
 LRyW5woC/F8fOtXQbE60wN+nyNhHJqFaQrXGcgvkIdjSeMEPHBP0UGmLQc/DlMK7Myvcmha6NBq
 a7R9i65yQ1O7/TjxzvKbo4c5VsEJosG9sqsIFAyo+cctWRU5+DVpaHS6Watckmbme0qFNGqMumJ
 ZK+SoYfWp7qA+QUakyhPHwWmBJCyojx0QWjNQ8jaXYHBMQvDDGeTv5aXLGbiN/X7cONQ6t+5gok
 bjmeSoRCll96nWdaXevAKoCcIZSlLAZtKNrPRTP2GWc9NskijVbNH/58e7ZJdTtHcrHe2AuqrDX
 5IoxbK++ZYng/eVj0Co2mqvxa7b9p17y2odXkzVfMnvcQiwUd3gp9OHNLvtUjXhwgnH2+9bLInl
 7QeLiTkq+oxQOUFnF2NkQSywZFTVeUuczgyvavqi+GMgYUPijvaprVjCA3R9hLuxKq/Xj99E9i0
 bHNrt3Nd6WdtF2JvBKm+xXlADr7nUv01fx/TDwiXIhzvk/GnJoT/ZfH0BqGi/ktIBdPqgujId+7
 xcRzaDdTjSY+NCHZL0FfykhDxXOXZjG03CXeFld/hXWHgD9mY3CgjRQ8lj2++jdO2J9Q3dLNRSB
 Ddhf8CtiibFMAxA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: CoFE6UCC23Zbb08IJhjLcfwK7vK6Lkc-
X-Authority-Analysis: v=2.4 cv=S83UAYsP c=1 sm=1 tr=0 ts=69a5b386 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=ZSnkYuKn9ZpO9KHknGoA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: CoFE6UCC23Zbb08IJhjLcfwK7vK6Lkc-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEzMyBTYWx0ZWRfX4MuYcNNqPIwF
 Q8YDrPr4BGR6Xqs4LlgGn5EromjUOjoIFxj9W4ICgoUy1Td6DF08rowHtwZt0ozWgsTT5hCALKU
 b8iuZfpzrzxF0yHpyuCJ0jON9COb0BLbVrKf6aerkcJoSsgdOlcDCPfgaYV6HDU2xz8rdX5gDd/
 BbqasIVj0zNOgiJmCO5apBuTnDRvd4C+DwUZ5DAST1y6DEljM5VBsdgL5HSV9TLbUjUH5MrcYuu
 bpJmgot1w/edVAtEYAkV5m4AmMPW18YKJh1BPc7exTEpNHsikaRl4psatXAxv+NP+Uqy9xWlpaX
 VXxWzuR+v4kVqEPhv5zJGI7O4i+a/pKKOkGHI7tZnD/+t7gEpXSwNjaIoocDHfiWFgoH05gSstN
 Rvc6RTndM3NUZ4gowLlJOavT+7KVVmGC96GpOPmVG9BvgmbV4TAvCfO61VvWRYJZ0Rd3hHYhWrk
 oF5MW9+14OPYwyr//5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020133
X-Rspamd-Queue-Id: 80A441DC6A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9186-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Extend the device match data with a flag indicating whether the IP
supports the BAM lock/unlock feature. Set it to true on BAM IP versions
1.4.0 and above.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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


