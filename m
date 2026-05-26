Return-Path: <dmaengine+bounces-10941-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Jl9DFScFWr9WgcAu9opvQ
	(envelope-from <dmaengine+bounces-10941-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 15:12:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BCB5D6278
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 15:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D34E8300D7A5
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 13:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252413DDDBB;
	Tue, 26 May 2026 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BZbeo/l/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GWVMaYae"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395723DEAF9
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 13:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801087; cv=none; b=fJL3pUP/tT+BmnCZSdkj+/OuT0s0M5oj3eaXoyZLK/OUSs7UaCCqSZNQdo5mCdlBibtiVHeFO3UmvCKTOmG4GUlBflBY+rzLTV/k3V4CCCWOZ3UFpSi5aJkqvXteh6EyvpMOMo1MplyPSsW8gHJR5dAAy9ezZGPvHUj3S0kWWl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801087; c=relaxed/simple;
	bh=yKvgG0rTvuvJLcjw7C6atYAtuGT91Jlwk9eV3sVaoBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gRXcWm+COTZYG19qEXEodvlORsaLQi/9c7w6ZctXHKCxfNUavR9Ni02UrCQuAvtJrxynQuRs+VFx5DU22CK0A2IzzPkiWrIxTBC9RkKA2Je8Urz1YfAhck87leVjOzUJaBl1q0JPGjvHkSpzCsVt2LhpN0rwKWysrIQzvnT5/I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BZbeo/l/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GWVMaYae; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QCsWiH2496588
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 13:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j2g7T67hXwVirNiCmNO6EC06JYgACQ8VaJoiHLwm9Nw=; b=BZbeo/l/mOWar0i7
	D/Ytr1655XiqsovVdEbKuxFZuUFVUgerl7dwyjrEqVPD3sUIyJih+upM7R9lW/Ez
	zdLO0WN7Dpf5+QfcYH4tdzK1xh/P7KNdaop3eWyEZfFkEtJTtZI1SKusjN2dIiCp
	ZBzaLNA9pytgHizseArXVt8Qz7mgVQmPiLBJYcpKSe8tv5d2r3is2b2X6PvI/2Oe
	o+PuvwH8ki/Gh2cLRrnrIYAVEiuayPr1bO1St/v1Xo1YAfr3vAHTJTaRIOYZS3JR
	YGtqOdXqKyUJn7HQftjZ/4Z78xauLbyiJCWbCTYp2ae8iCpmUn1ylZzo3K6RXz6X
	0/3BHg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecpyqmd90-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 13:11:24 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-6751db2792dso1854693137.3
        for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 06:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779801083; x=1780405883; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j2g7T67hXwVirNiCmNO6EC06JYgACQ8VaJoiHLwm9Nw=;
        b=GWVMaYaeeTxS+2VDDSTacBaas0StFK6WfQgBxL3bdr+c0HshS+YUkN4Cu2oVAm+/rO
         8nE7m3ewaYmHeu54NbAYpxt8LsSxMmq+zaALsbJ0AHvIPAbX4ZajOP9DLVgnMotRMleU
         y4znUGR1VLsNLdvSAnkHRR1bCUJ9m2ZahKyYR3d7b9q90BJbww7X+HR8hVJeybMa6sN3
         BE6eLVp47kLQ7cCKDVsK4rerog7x76XEzuvvWxv9LmZAbEzD0evy0b/K2X0imPMJkbaV
         Y9wYpcyLqOAPV7tgsHLbswO/4Ljn8YF+u5ArFFFy/uGHKCK1zPNWS/plOa/1T32zztid
         q59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779801083; x=1780405883;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j2g7T67hXwVirNiCmNO6EC06JYgACQ8VaJoiHLwm9Nw=;
        b=AlR6mNtzP0BlBOXbPGyuxwBLu6tQMPKZdiosXyySb55a6UFu/eT9C6icEPdiedxefz
         UNOpCcfj2aNd+F0ABf1vVo7gZXKwxuSpN/49A/vCO4yiVZsPzJhpfB7SLiczd2xuarQy
         zyF7QbugA1B19JxMya1w1NMbkSmCsW/hgAvO0cF+9H6FyIFrmBDP4GTXf88qMWAlS31l
         O999NtOFulYWqeURWglGyOUxzGC8Eoq084HmV+UfbiosLAXrDRXVYOdZbBm9pW1GfkqO
         aNFGkVT6MrXxrQ8bC1A/VjL45++Jb6tKfXgJKld1LJDO970DXKcIu4MmBSZxWoPmDn4y
         XhfA==
X-Gm-Message-State: AOJu0Yz4U8RlAqA8ALAbb9fArhVJF2j6CBjyfjSglmG7EZxPFjpVV24w
	GJ/f+QLygeNzEgepSqz111knO52brfo+U9euc278X5D5rknt8FaHQraI+2N+0ZOdvOzK3oMs1B+
	2w1PrVSS0NI7W0c4NjpnaZQ5qtlGqiBaQ28/vUNHAyF4d/aSvy1ubYZHYdNNNFpU=
X-Gm-Gg: Acq92OH0oiXc+xVtj5W36HyT7qYOUAMjWlJVdKUKVxAaw/sW+WfWUVOyaae5jTOOu/v
	XE2oY52C/eng5BFoQqrE34txsQugNmfZ5ROw2bhFsKeh6y85786mpvGQEzotWiuR35XC5if8P+8
	l/b4OS4aewbllTcE3ns+KDW0o/eggItCn2SzyEwftB1wAM/YL5qLoJhsYKeIUfWAlK1JlJL3+mQ
	s7N15go/2Lec3CX/UW8ji1Wql0yRGIXwcvsdO4U1xwuo93pV+hLCHD2CD0C93XCiQuaoJ1/x8fC
	tO1o71wRiFNT/9xyy3c7nM8HB/t3rbLMLjGOnKFk58Orb4F67RLdPliGna1HpKTHKyFFo9k5rpC
	jkRGhT/TgXkSjgZOk7SPABKKvk7y2PJMIWHgEHxKRmS8wMCSY1C0=
X-Received: by 2002:a05:6102:26c1:b0:631:7781:fe8f with SMTP id ada2fe7eead31-67c8a075be3mr8074430137.16.1779801083410;
        Tue, 26 May 2026 06:11:23 -0700 (PDT)
X-Received: by 2002:a05:6102:26c1:b0:631:7781:fe8f with SMTP id ada2fe7eead31-67c8a075be3mr8074354137.16.1779801082801;
        Tue, 26 May 2026 06:11:22 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:15ba:1d70:65ea:9578])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5e484sm34259426f8f.30.2026.05.26.06.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 06:11:21 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 26 May 2026 15:10:50 +0200
Subject: [PATCH v19 02/14] dmaengine: qcom: bam_dma: free interrupt before
 the clock in error path
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-qcom-qce-cmd-descr-v19-2-08472fdcbf4a@oss.qualcomm.com>
References: <20260526-qcom-qce-cmd-descr-v19-0-08472fdcbf4a@oss.qualcomm.com>
In-Reply-To: <20260526-qcom-qce-cmd-descr-v19-0-08472fdcbf4a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2764;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=yKvgG0rTvuvJLcjw7C6atYAtuGT91Jlwk9eV3sVaoBM=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqFZvp7UZaBHl1OIOMCNcm6ZGnEtt0oh2iZGyPw
 ENtMY6cdtGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCahWb6QAKCRAFnS7L/zaE
 w5SJD/sEn+AzlgXKKc1pQ0NeSWVBb7BQcNXQaxKPk6q72SYnU8eCWrAuvmeH84F2l+i+cL0zAWb
 nmEHYZx3GSXz7cwvHKyBGoOKjrh5xhzTSTPvT6wn1bVPx0R4nN9HTVm3PcjSOWUWf61eRHZP1la
 +UNcU6Ul345VLALhUJh0NFWmdc4cCQZwLQ4p5ClI+tfHkBfVtrayM+N+r+RJZMONh4SbhNbTORy
 WCJFWf4KIjB8sZHqByTiesO+z9uFsxcCGiAVzL3lT895g79R7zaNFbvtfnpCQDniy3UzVYV2Vu/
 upq+wwHrIq94JxPbJQA10Dh9USJPv3OtgrrPx9CoFD3c8R7qEQOmjADC+/oK9IRf9Ah2iwmzmZn
 cxZ7yw+CAagm3e1Ra4c/wxKvk25sNeAr+utNF0ybsjITjR0DJxSnqkEqeY3zFGenYFDqg4MLXHf
 3AF1iUfndmbkSe09RX9ngzipL5RXKZ0n/4Tva9DF+U510x6hzGHe7gOzjHxNEXW7ly0j5FiXqJG
 D3lEDwlhlaM/XbyA5Msi5zXa4CH+sjLFF9gXie7/G5LvJYK28w960meiu9aGttA79tfjoXMyDJc
 l2CzzFbgE1evjGeiQhxHVRt0SdIdTdiGFr1nrnxiXjfrleDZjNftmUdEHXC8BaIvMUbGlN+Bnkw
 MQLtAaAgcEspIHQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=dtfrzVg4 c=1 sm=1 tr=0 ts=6a159bfc cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=n8zAjjMAgf0wD31B80cA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: 3GZAhYSQaTLCB0O6Vp7tGBYTE75pv6kh
X-Proofpoint-ORIG-GUID: 3GZAhYSQaTLCB0O6Vp7tGBYTE75pv6kh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDExNCBTYWx0ZWRfX2xwHDjUPTn/g
 lsBlJ6KG99MCOllDOOy+sEblip6JFrwqLOGgMy4xPHM1FTINxnomxW9mRU+ynNJUZmQwy4LkQuj
 g8tXtCOXLff05G9e6EwyJZ9RCeGB6lO/VKgmGEnw4cJHHaxrDZo0y6/h24YBQMd0cxAxoB2xnp4
 h3uZ1aWFcT3LlVaKKS84YoofNti9wXny7FAyFHR1S6sETIlkgkh1mPn7wCANnDlFmonHiF3hVMS
 vcaWUHd9+tJdzAulzv6AQt6Gf1oflSeqCA1mM5jYY4TtoJsoLa3kIstF75+fmIrBzHyBMQTUQey
 CRF6B1IAIXqkFq7MoDedynwPhUm12G3If2/3lkw+saDNK+9uZ1KKR9SvOuFxbqvoloev2lftSR1
 52HiYp/jQ4YMIlRaC4vpH9EqZ6v49vV5AfmkeTR/0KJ/iV/xN2CopRjJg+zXhwNCt+MgD26lNYT
 eQU0e5xIgUuq9SSgmug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260114
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10941-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sashiko.dev:url];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: 38BCB5D6278
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The BAM interrupt is requested with a devres helper and so on error it's
freed after probe() returns. We disable the clock before freeing or
masking it so it may still fire and we may end up reading BAM registers
with clock disabled.

Stop using devres for interrupts as we free it in remove() manually
anyway. Add an appropriate label and free the interrupt before disabling
the clock in error path and in remove().

Fixes: e7c0fe2a5c84 ("dmaengine: add Qualcomm BAM dma driver")
Closes: https://sashiko.dev/#/patchset/20260427-qcom-qce-cmd-descr-v16-0-945fd1cafbbc%40oss.qualcomm.com?part=2
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/dma/qcom/bam_dma.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 19116295f8325767a0d97a7848077885b118241c..b3d36ea79984385fe0d05ce56042d3e6e3030c5a 100644
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
@@ -1371,6 +1372,8 @@ static void bam_dma_remove(struct platform_device *pdev)
 	struct bam_device *bdev = platform_get_drvdata(pdev);
 	u32 i;
 
+	free_irq(bdev->irq, bdev);
+
 	pm_runtime_force_suspend(&pdev->dev);
 
 	of_dma_controller_free(pdev->dev.of_node);
@@ -1379,8 +1382,6 @@ static void bam_dma_remove(struct platform_device *pdev)
 	/* mask all interrupts for this execution environment */
 	writel_relaxed(0, bam_addr(bdev, 0,  BAM_IRQ_SRCS_MSK_EE));
 
-	devm_free_irq(bdev->dev, bdev->irq, bdev);
-
 	for (i = 0; i < bdev->num_channels; i++) {
 		bam_dma_terminate_all(&bdev->channels[i].vc.chan);
 		tasklet_kill(&bdev->channels[i].vc.task);

-- 
2.47.3


