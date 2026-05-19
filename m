Return-Path: <dmaengine+bounces-10540-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGKiDgZlDGpXggUAu9opvQ
	(envelope-from <dmaengine+bounces-10540-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:26:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A455857F9A7
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D9103109982
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 13:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F06348C4A;
	Tue, 19 May 2026 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JkNp9NOI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gynW/fiv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3F74A2E1E
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779196702; cv=none; b=TTBLo3a3J4Stg1NqlmCCdkSHYBPXjeRruHXm/VszIDfawBXE1CuRE5c5d8ZL4JY1Ouf2y8g3ly3bX5kCcJ8iu1L7regdlYtgw/d6Bu05h1zm41CDz0u6VvBCsR7LpthcNvYoCFqipaJ8s5QDwpAud3V+q8vt5BFoK1SVrd9mdNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779196702; c=relaxed/simple;
	bh=FjlWrhg64aXopk2c8TNW8F0ETOsoah/nz+L00f7HWu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nAfKGhJpMszsQ5mGhhkqYtxi5XifPlIokmloMwrHli9G22cj4mO7q48P6MyD7Bs48b8aH9V+8JpxgNZmnPWFsJ6ueBkR+7Zx1EJVJNfe07JzNNn4QCxJcgWVLehJSRyfwAmoRfTb8yTs17Tm/YUM+7dkuY6COPpUKIzQqfR8KGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JkNp9NOI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gynW/fiv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JCZhSO1395799
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1Gr0t6VI/a0hOXrs496vSrF8FkdFJvUknR0vCq1ph70=; b=JkNp9NOIXoxe9TZv
	FR5IE7jqxMa7D63RJSLPOYEmsJlQ1KK5vGaPhXT8UgrhZPACpSSS25Lxw2J/v3qC
	YMWWFUuiJFTsC2viMmb9jVfnygIF6CLuLzM9R4hzSNaGMx0rWUdwCD1Ozq5TCgcU
	rQU7gfM+VWMtrxE6tb2niuPltB1ueqavLthCyqoVkBzwK/NWvoymU34ncnWBcG5n
	rWXfGSqG5zU/0OOdnbGuAyX1z+PzBXBcQCK3VwNfnQP+b+ZnWnCJ01bfW8LLsItC
	Di8PHpdUJBD3rcp3QTiO68OQCbNR4jUQjljQvmassS+XeHFPOggiF/ch5mjV8hUd
	zKamGA==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8r0q05bf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:18:20 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-484ba8ca080so2765452b6e.0
        for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 06:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779196699; x=1779801499; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Gr0t6VI/a0hOXrs496vSrF8FkdFJvUknR0vCq1ph70=;
        b=gynW/fivuNHYfNpN7/cZBw2TYrKe9uU28geaMbo9/C22JV6QoIaDnO6yCINLk4+DWk
         SYpP0PFyCoDrG2CtWDqqGmiwFTwpA4C+QIjWFMdN9Je+F2xU8hah7pT91IvvZNm0ntKi
         te4TnkuRVxmGzq58fkXvTwP8EghKnhzmJfpsggy8CcJtMFBPP6Hj2S9DQ/rs+4KaOgHS
         kcNsZyiNIB+zIFoQ/0/TJYkmMviltwbXNcI0ONpoTlGxbRosdXE5kfCiPsfceoS/NBv0
         A7YRqN0tYYkoe4KBr+fyZC/Dk6DVkGWHchxJZYO9vRitcsK2N4KagSCD2Wj2bc/k5vfR
         a0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779196699; x=1779801499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1Gr0t6VI/a0hOXrs496vSrF8FkdFJvUknR0vCq1ph70=;
        b=BoCEUo8O9Ukoa2Zxek9ClSHjBpfjrnqaBW8axUQPAVDBwddJNkAkcmoyftFOPalNyD
         lETv3gHYlu83+VQpWJRWWgiHH15YCCBP2vvKZovewFy2AeklqomyHlMb0xQr7fOxzRPy
         f4DE3LL98xz0Z+Y6ZK5/eSD2kGXXLab2HTdSjgjwZQcCfGvwHKKAh1+rNw3vmzCL+wLj
         Di87vMNpNoZvNJEw8fZmZRVb4imI20lAnsqMhEjyMpeNRIWByqOhqYBk+I6Dul27nuHM
         moqcK6y1UqZty14hgupNncrxSU8D7Nk9H1tijWXGEy9xMF7bObQvGgiIgYaZVfhA6T4Q
         Yo/Q==
X-Gm-Message-State: AOJu0YyN6LrJt0Zm2X7bf831EH5DYoYpyNwT44lGeG8v1sJYTDroBa4I
	yk1kTrj3B/VGxwivlgze4BmD+z9oOiLjAMhlXOixTHTY7m/aqBeZA558naU3oRGxr3oUAK5fabg
	qTcfsebkEqzDPyPXJHAfww5oakRuSYsLCWybEnn7ak9lpN+suU9Nq2ebbqarJlXA=
X-Gm-Gg: Acq92OF5XitvBQvF4HNAlSGyd088Fe7aT4+e6fJ8Xj7g/oqCSGG3y4SFHcbqr+akcYM
	Eu8Klv9Lv5Qu//kRnZfoECQrCKjSNMN0TCCOdCsIkEZ8FNFSVu8/zxrmWuWQQqSr4GTYZmYSyVj
	kJOSyBUxnYi0hqhe593yekENBayZP2Wtc6BUY+ZRvQtNUmnxjWqMS2FxlIolZaP1cITPSnjT6SL
	f6Xj3HD0CFzTJ2Umhbo7ubcIUEaCllTHTqBU+b1cV0LokdsO2wsurXyYzu9PRc3UVlN7KKvyWXD
	DbhrVHGOAtTrb6eqkW+r+fNpZ8m9X9si1npJsLdbjtK6wQAozMRb/dEQAVaU5p7gBpCQyZ8CRwV
	70BAo9vu2QuJjlL2g3lUgZ4w6dzsXnco8TEh9a+ZRY3gQ9mO6ocE=
X-Received: by 2002:a05:6808:50a6:b0:479:fe0e:e83e with SMTP id 5614622812f47-482e560891emr13202794b6e.14.1779196699283;
        Tue, 19 May 2026 06:18:19 -0700 (PDT)
X-Received: by 2002:a05:6808:50a6:b0:479:fe0e:e83e with SMTP id 5614622812f47-482e560891emr13202768b6e.14.1779196698704;
        Tue, 19 May 2026 06:18:18 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:3fb6:74e3:3c25:ba2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe7dd22sm143969195e9.7.2026.05.19.06.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:18:17 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 19 May 2026 15:17:47 +0200
Subject: [PATCH v17 05/14] dmaengine: qcom: bam_dma: Add
 pipe_lock_supported flag support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-qcom-qce-cmd-descr-v17-5-53a595414b79@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1530;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=95UZqYCVoso2D8UWFsBEOl96nt3UOjBik5wfLsq4Ngs=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDGMGcHdXbfyHT99vDrDX+RrK/0ep7PuqhyhyR
 nnEczoWRnWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCagxjBgAKCRAFnS7L/zaE
 w5ThEACBFJwqWuIBl/1eTJS4fTvqoKnroUsfcrhv/TH82B5fHMnFllZQw2arhmDFjmel7jjoQpK
 va/zXYByx92u2Sb7LeXe2wzPO0wME5W8+6Gf3tS6VXg5ataVwgVFZgIhSpWOmUmaNYrgP/3kLUL
 C11zAAjEILXj9zQF5FhHxRB23NnKCKc98FVffOeegnf9Fy2cdcUmKoupF/Xtdwg0wVFYpr2hL6N
 xwHTe1vHdXkB8HoPtKBNJIdCWCVAWQ+iHo/Zx2Oa1A0L9VSg24WTFSibQ+va2dear/TzawVUS+/
 zA56o0x/goHUsNpR3V/fAgnp/b29N5vK0iuz7YCLMIbwYRUItpHoititqPrYtjNF9Pmr7JeReWC
 NwPitUtpPEd//vpuOQ868vp7DZ9LDyJpvlLG/GWQDtsk2hPWsPjOlf6yrE6gyyWF6KDXQWe65HA
 VaIdaLFWYGus05MtH0nbgCWf3FCZ6g2u9GQ42MqcgWQ3aP8QHAIvUnhBR26ajda7W38YEkr0Z3s
 Ck3zlSsLljlFVvfGM9y7kCywteZcnmrSrHrjGpzQurDS1M68Lx7CKjMl3fWNAjYUXEKWzZoTfUH
 V5HZpfGWQDCgM1XgMKyEEvSOuGc5GIo3m8m7rOu9TFfoRUTWzXDB/NWXppwFWxdevONF3FBjU+F
 rAXrD27c+U7tjxA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEzMSBTYWx0ZWRfX6PvrWmnk4Vzf
 iEhH3YozLnQ2CaENwSIkesW9B5dNA0o7o1PoUVjZ3SiWNpw62Cq/W9kHSpl73+4YkRhbFzKuPex
 SHZbFPs10n8EUt+tClmiXKnuKhMADyGnLN8o9tl15XsaBiznVz6vVCOh8HMV3Jvp1vyWJlvacua
 ANZKK5gKCT+cEHl1nNnSxTevPMIa9kagW856zqxdY4eZCLwENi13agQ1lMHyCSxZSpwMTRXLwSg
 ugrdEp679aUUU2T+oMFHEM5yW1YloVMYhrdjIp8MxqJNqcwST73RrPk7VvmIxf0S2KjE0LUzymi
 sYF407r5lwD+ewAk7Qg1ypEj+z82r8N4u9TWuVTIy814KLuPqQWihYf+nfEFWASrNZ0cS01vL4T
 j55OE/YNtZ4975PXioobcEqB9P5+0hIqIaxbS3wfCwJn3E38NORserKPseNTICIXw94wGK5Hgzp
 WLEKeTWk3RB0hyW2clQ==
X-Proofpoint-GUID: 1U5biIH6Jeri36yprqYz4G3hg9STfCbK
X-Authority-Analysis: v=2.4 cv=Q6/iJY2a c=1 sm=1 tr=0 ts=6a0c631c cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=ZSnkYuKn9ZpO9KHknGoA:9 a=QEXdDO2ut3YA:10
 a=TPnrazJqx2CeVZ-ItzZ-:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 1U5biIH6Jeri36yprqYz4G3hg9STfCbK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190131
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10540-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linaro.org:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: A455857F9A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Extend the device match data with a flag indicating whether the IP
supports the BAM lock/unlock feature. Set it to true on BAM IP versions
1.4.0 and above.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/dma/qcom/bam_dma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 7f3d1b6dd5d7660d2743dafcc43878e5f7952b8d..30318cf01ee20b7e64a988e8ce1ec04dab55e3c3 100644
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


