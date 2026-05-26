Return-Path: <dmaengine+bounces-10945-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6A0hFnKfFWr9WgcAu9opvQ
	(envelope-from <dmaengine+bounces-10945-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 15:26:10 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A91605D66AD
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 15:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43788341AD5F
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 13:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F213FCB03;
	Tue, 26 May 2026 13:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AjUmkbJn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y3L19aMY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9993FBEC2
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801095; cv=none; b=bRVxBY4D28cq0fFolF8DnS/D+rnCskYLtkol/vlSgnOlICuEVOEAECDpKAUEPbFzSAQGuv6+85obTa1t0WVVe1wmUAy/sT+X5PEtvaf6vrI70fyXL1/11+SxQd1NAOiet53NwW37gBYWpqedjzBKQz7/+82nT4w8SXjEvcUReVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801095; c=relaxed/simple;
	bh=gwfKXaVEiVIBtazssjucoj3rS7WWAo2eUOnSd/TMZv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ILytXNXwLy+2aeMlbessESuY+s//X//FRtG7N/w9rP7VRajEb6OENkROWnfZJXZwpHvUhfFr2qPRplyChMeitoM6I7Ar9/pf6/bPQlQCBcke00yC4SPODy4PjfJYypNYpI4BsA4Uqn6YxLZRN03MT0IocKngSjmef5YKJmfophM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AjUmkbJn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y3L19aMY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QCsO0P2697727
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 13:11:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oCU3VsxGEdjPBCoGd41WaHJI7aWQRWqjQ950S1o2Zrs=; b=AjUmkbJnp6qVhCB5
	pXdlhv+8zhgzNwFDRak5tSyJLkzurACylamJplV2mXDU/2ww0RbMmL+1K3b5Acft
	nGasV1nf7KTQ4wW3J5SYJVlaSjk9kuREYeilbukArfp+KjbgGAVAQMkczXRUXi7A
	sF6WvCcomWBqDlpXH/J89V5y5L1HK99+YwMjWFtYBI3GReXRuikGiEwWswkYLVoh
	KmWEElPPSVm1UyyoAowMf0YUDHz/FGmq/+abbrlAXfNMbl9E5WwMrjq+3/WSlIp7
	mtNfEq0vtPnCpkkVmzSeUkXOh7v3F0miZFAh20/EytaHnNnF0/jDIv9jR9R6bdS3
	DS8ORA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecsm03u8d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 13:11:32 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-639389de134so4263871137.2
        for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 06:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779801092; x=1780405892; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oCU3VsxGEdjPBCoGd41WaHJI7aWQRWqjQ950S1o2Zrs=;
        b=Y3L19aMYGpP/+SSzJ5qrUsmU/DSgEuIPCmUen5kA5CiM51keRugIJddcSFm7XIyJSH
         tqljxCgN10PFl3jf6KGKB9vJnV2E/aWTS4QxTv+5xXPq/E8A047/Vy8ZvS5/GKpjhpB/
         28aLfgcN1Q1igahPaZLq8n+zrbuyok8UXnBH1lepx3h+verIp2KCvLrqBfvkEd5yubka
         sCHizIEi7n6mgpocwZtykE/JAt+huktsZRSougrNQvS4rfxzyvvGhhBsFmf6JJ7wWOmZ
         noDA8RrxGTFnaP00d0NURYRWHu2amejnrnVw0JRIWAa3Phm3fwwb+BMtoKO/GU/sfLpw
         XwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779801092; x=1780405892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oCU3VsxGEdjPBCoGd41WaHJI7aWQRWqjQ950S1o2Zrs=;
        b=MWy/tU7bW1e5IqOg425VzWIpQHblM/LV0rLVqAIbOvnQZzIXqNdGIYuXfxAUZsKc7i
         lhg9y8l1j6CG/RG3o1r+NLYBy2YOSZo0/F+FHKHNEjQ/zMEy1Cq7UgwGxz+aouQDdV+h
         KI8arQ/L+hIlg1rp3zioYWckPX3CxCmphVJAQCzKI1bit/AOkhkDebgE2OGJnr9RtOkj
         Zx4Y0lWjQGsn3eg/NovPjyZ+esp/x4ula/lQBZaEfJZPkShgke0ID/Y0BV7L6/DE8Va8
         cZqLUZEhc8UxoIXy1YT4MiAeLJdeRoM/TbqDnObs3iyUUHLJcvZjT5wnGW7+t/ktv6tr
         X36Q==
X-Gm-Message-State: AOJu0YzQLUib8Me4e3x2AZWz3K+K96uX3pAnrKhGV35NNSPuBnKvJ2TX
	1HqZxH3ZwtUlxTj2weAgKqNBwoFwZZiFr6KuN6azsdEBoJe5bfZNfWH3A/xSSm4g1Zmb8xDhFE6
	fRuQFxAxm8b6TfEAOIfSNltz5OgDOMESfyBmKz2No/RBBq9EUtX/1i6zOgTL3Ulk=
X-Gm-Gg: Acq92OFsgf+X+zzYQnih7l2tcgHAB/UoNcN4TgjMb4YpDNrF9/kcZakqmU3PD08aa2h
	IX6Z5egKIoEAQFduxP7Ue7qez9BJnp2+TqHjIcwx6aPtq/omdr9KlUgqAnft8qxPqsCWLyYKBXx
	HAWx62RYEq5zsvafnCqeGBuVG2fYes+EJES/dB2fDhEfvxf680Tndc0RuCkSubfMFDmgmyJvdH8
	Qyvse9Zq+RACBJLtW2rZbcdj3z3MP4XlCK4FqCYNq5e9gSZ//NwMHP1HFetDupjyRJbNilhgIt2
	07QIwPRea3mBsfr8SxKJlDUTas5Kr1McGtoZ6LKH6QoRnMs6x3i8UhR132MRSnkGkylgFbi+wXK
	ibxEKZC6A7X7x7qPLW+cXNh+ByhNLMVA6ADB1GFyLSsiZohrZ3zE=
X-Received: by 2002:a05:6102:c07:b0:631:2f82:c3ce with SMTP id ada2fe7eead31-67c77ff1283mr7782049137.10.1779801091382;
        Tue, 26 May 2026 06:11:31 -0700 (PDT)
X-Received: by 2002:a05:6102:c07:b0:631:2f82:c3ce with SMTP id ada2fe7eead31-67c77ff1283mr7781951137.10.1779801090577;
        Tue, 26 May 2026 06:11:30 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:15ba:1d70:65ea:9578])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5e484sm34259426f8f.30.2026.05.26.06.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 06:11:29 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 26 May 2026 15:10:54 +0200
Subject: [PATCH v19 06/14] dmaengine: qcom: bam_dma: add support for BAM
 locking
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-qcom-qce-cmd-descr-v19-6-08472fdcbf4a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9514;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=gwfKXaVEiVIBtazssjucoj3rS7WWAo2eUOnSd/TMZv0=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqFZvtj4BqUHDrNP0sdg0saKBsOM2MRyh34m6Dy
 EFU7o3qF+uJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCahWb7QAKCRAFnS7L/zaE
 wz+cEACZYnUIzTy6zDUIO7SgdoD6QjR30C/Nxhwa8F8J0L+2NH8N1aqvbwZytTgSi55IhlnprAf
 kytBTd8ZYRi0Fl4z0ULnsTtaJujaAewSZZ9WitZuDbOxuw5OsHySSmBr3QY7QJpGgxKyycGA05D
 kY04xLeExmzTF7AaFcYRit8Aq12GHDi7fiqSH8dwkcLD+18xgpNnL40BkaN4Ye4GmSRQOXre17s
 ebekpT2BSJCLjnJypO1l2Jdg9s1mbOZxqto9SIVd5X2v4LNFVu+/XZk2Ot72227MJFs702NeXau
 kfTzswEcb4grbIj4JUOpYyslutAuCqJZjBT0pQOPD+9VhPGl/+flp76E8PJWB2SV54MV8V0mpdp
 gHPAMG0Q7Elg8GKZwISvbQG4C/VHSSo/azPv0ooqgXipmZ+90r91Lw3i4f0+UoZQX6VIvxd0Se1
 xuilqeV5PDpVnWIDDzEc9/LswhTeAkjzp7wzB4Ge30T4uv5afK7VeTh3I4aGqKzC8ekUQaw8G0/
 0Mj0qdsvtrA5KIHEyfGBc0XI7ItVjE6E4xhl5C9ecjiGyieuKUgaXESVDZUtjSNadI9Ov8UKyY4
 14v526wQn/c4qN+QQ8O0Qr+0B023fGbosntlXvJq4oYI0dUre8yBtFEtevUi9Oy73rB4lnnFXen
 bHrMyUSJg+fnpog==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=CLEamxrD c=1 sm=1 tr=0 ts=6a159c04 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=j-cXwOq41x9PnjJ4jooA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: QOOHeCipo7IY9Zm9Vh626M-rbjaqrHyO
X-Proofpoint-ORIG-GUID: QOOHeCipo7IY9Zm9Vh626M-rbjaqrHyO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDExNCBTYWx0ZWRfX0OSzu7SSx4Bo
 0mEERwmtFscoEyGCeUsYt3F57hkhgdjFBnyxz5mcHxW2cDuJ8UPLR3wqah2eiFUz6R+PR6RtqC4
 k460I1PrjLP4wOfy/Id2O2YdhV6+yEjYmVb0jG8wQpxs4eagNdnwtmBnG6oU9KTneBYQPHvQ6OD
 b6fH00xhCOrXGznGmFgEw59U8tT763gN0DzieBbZPgeK3TAXoo6Y+dHCyaCPocQgccaik2pM8Um
 bs8rvPaLxrKubJ+Ex/i5QPkrt9uWqo3BBuV3/TmoFCXFHb0HeEFr3cnSu9GPnTB0nVpRCt396pZ
 mu8w3esjwsptCmmenWPlyBhO7vfo/1vY7xWM7LkomzuSuULSE/06QAeDKqiL6GMZf2N53bwLAJF
 WNODb92pgZHWMLfK7hIbpoM2BgvmFpvQgxp8+/FYJQg8M+Nfh+7fWhU79+VsZnJSAlwZ4mUEOl9
 1xF2gYlkYjxSL1O2+FQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260114
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10945-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A91605D66AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for BAM pipe locking. To that end: when starting DMA on an RX
channel - prepend the existing queue of issued descriptors with an
additional "dummy" command descriptor with the LOCK bit set. Once the
transaction is done (no more issued descriptors), issue one more dummy
descriptor with the UNLOCK bit.

We *must* wait until the transaction is signalled as done because we
must not perform any writes into config registers while the engine is
busy.

The dummy writes must be issued into a scratchpad register of the client
so provide a mechanism to communicate the right address via descriptor
metadata.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/dma/qcom/bam_dma.c       | 153 ++++++++++++++++++++++++++++++++++++++-
 include/linux/dma/qcom_bam_dma.h |  14 ++++
 2 files changed, 163 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 04fe1d546be73f074c66c4a5712ad65717e10929..84fd9e181bdd5fd9a4a744050ba57f05f54787c7 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -28,11 +28,13 @@
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma/qcom_bam_dma.h>
 #include <linux/dmaengine.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/lockdep.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_dma.h>
@@ -60,6 +62,8 @@ struct bam_desc_hw {
 #define DESC_FLAG_EOB BIT(13)
 #define DESC_FLAG_NWD BIT(12)
 #define DESC_FLAG_CMD BIT(11)
+#define DESC_FLAG_LOCK BIT(10)
+#define DESC_FLAG_UNLOCK BIT(9)
 
 struct bam_async_desc {
 	struct virt_dma_desc vd;
@@ -72,6 +76,10 @@ struct bam_async_desc {
 
 	struct bam_desc_hw *curr_desc;
 
+	/* BAM locking infrastructure */
+	struct scatterlist lock_sg;
+	struct bam_cmd_element lock_ce;
+
 	/* list node for the desc in the bam_chan list of descriptors */
 	struct list_head desc_node;
 	enum dma_transfer_direction dir;
@@ -391,6 +399,10 @@ struct bam_chan {
 	struct list_head desc_list;
 
 	struct list_head node;
+
+	/* BAM locking infrastructure */
+	phys_addr_t scratchpad_addr;
+	enum dma_transfer_direction direction;
 };
 
 static inline struct bam_chan *to_bam_chan(struct dma_chan *common)
@@ -652,6 +664,35 @@ static int bam_slave_config(struct dma_chan *chan,
 	return 0;
 }
 
+static int bam_metadata_attach(struct dma_async_tx_descriptor *desc, void *data, size_t len)
+{
+	struct bam_chan *bchan = to_bam_chan(desc->chan);
+	const struct bam_device_data *bdata = bchan->bdev->dev_data;
+	struct bam_desc_metadata *metadata = data;
+
+	if (!data)
+		return -EINVAL;
+
+	if (!bdata->pipe_lock_supported)
+		/*
+		 * The client wants to use locking but this BAM version doesn't
+		 * support it. Don't return an error here as this will stop the
+		 * client from using DMA at all for no reason.
+		 */
+		return 0;
+
+	guard(spinlock_irqsave)(&bchan->vc.lock);
+
+	bchan->scratchpad_addr = metadata->scratchpad_addr;
+	bchan->direction = metadata->direction;
+
+	return 0;
+}
+
+static const struct dma_descriptor_metadata_ops bam_metadata_ops = {
+	.attach = bam_metadata_attach,
+};
+
 /**
  * bam_prep_slave_sg - Prep slave sg transaction
  *
@@ -668,6 +709,7 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
 	void *context)
 {
 	struct bam_chan *bchan = to_bam_chan(chan);
+	struct dma_async_tx_descriptor *tx_desc;
 	struct bam_device *bdev = bchan->bdev;
 	struct bam_async_desc *async_desc;
 	struct scatterlist *sg;
@@ -723,7 +765,10 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
 		} while (remainder > 0);
 	}
 
-	return vchan_tx_prep(&bchan->vc, &async_desc->vd, flags);
+	tx_desc = vchan_tx_prep(&bchan->vc, &async_desc->vd, flags);
+	tx_desc->metadata_ops = &bam_metadata_ops;
+
+	return tx_desc;
 }
 
 /**
@@ -1012,13 +1057,105 @@ static void bam_apply_new_config(struct bam_chan *bchan,
 	bchan->reconfigure = 0;
 }
 
+static struct bam_async_desc *
+bam_make_lock_desc(struct bam_chan *bchan, unsigned long flag)
+{
+	struct dma_chan *chan = &bchan->vc.chan;
+	struct bam_async_desc *async_desc;
+	struct bam_desc_hw *desc;
+	struct virt_dma_desc *vd;
+	struct virt_dma_chan *vc;
+	unsigned int mapped;
+	dma_cookie_t cookie;
+	int ret;
+
+	async_desc = kzalloc_flex(*async_desc, desc, 1, GFP_NOWAIT);
+	if (!async_desc) {
+		dev_err(bchan->bdev->dev, "failed to allocate the BAM lock descriptor\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	sg_init_table(&async_desc->lock_sg, 1);
+
+	async_desc->num_desc = 1;
+	async_desc->curr_desc = async_desc->desc;
+	async_desc->dir = DMA_MEM_TO_DEV;
+
+	desc = async_desc->desc;
+
+	bam_prep_ce_le32(&async_desc->lock_ce, bchan->scratchpad_addr, BAM_WRITE_COMMAND, 0);
+	sg_set_buf(&async_desc->lock_sg, &async_desc->lock_ce, sizeof(async_desc->lock_ce));
+
+	mapped = dma_map_sg(chan->slave, &async_desc->lock_sg, 1, DMA_TO_DEVICE);
+	if (!mapped) {
+		kfree(async_desc);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	desc->flags |= cpu_to_le16(DESC_FLAG_CMD | flag);
+	desc->addr = sg_dma_address(&async_desc->lock_sg);
+	desc->size = cpu_to_le16(sizeof(struct bam_cmd_element));
+
+	vc = &bchan->vc;
+	vd = &async_desc->vd;
+
+	dma_async_tx_descriptor_init(&vd->tx, &vc->chan);
+	vd->tx.flags = DMA_PREP_CMD;
+	vd->tx.desc_free = vchan_tx_desc_free;
+	vd->tx_result.result = DMA_TRANS_NOERROR;
+	vd->tx_result.residue = 0;
+
+	cookie = dma_cookie_assign(&vd->tx);
+	ret = dma_submit_error(cookie);
+	if (ret) {
+		dma_unmap_sg(chan->slave, &async_desc->lock_sg, 1, DMA_TO_DEVICE);
+		kfree(async_desc);
+		return ERR_PTR(ret);
+	}
+
+	return async_desc;
+}
+
+static int bam_do_setup_pipe_lock(struct bam_chan *bchan, bool lock)
+{
+	struct bam_device *bdev = bchan->bdev;
+	const struct bam_device_data *bdata = bdev->dev_data;
+	struct bam_async_desc *lock_desc;
+	unsigned long flag;
+
+	lockdep_assert_held(&bchan->vc.lock);
+
+	if (!bdata->pipe_lock_supported || !bchan->scratchpad_addr ||
+	    bchan->direction != DMA_MEM_TO_DEV)
+		return 0;
+
+	flag = lock ? DESC_FLAG_LOCK : DESC_FLAG_UNLOCK;
+
+	lock_desc = bam_make_lock_desc(bchan, flag);
+	if (IS_ERR(lock_desc))
+		return PTR_ERR(lock_desc);
+
+	if (lock)
+		list_add(&lock_desc->vd.node, &bchan->vc.desc_issued);
+	else
+		list_add_tail(&lock_desc->vd.node, &bchan->vc.desc_issued);
+
+	return 0;
+}
+
+static void bam_setup_pipe_lock(struct bam_chan *bchan)
+{
+	if (bam_do_setup_pipe_lock(bchan, true) || bam_do_setup_pipe_lock(bchan, false))
+		dev_err(bchan->vc.chan.slave, "Failed to setup BAM pipe lock descriptors");
+}
+
 /**
  * bam_start_dma - start next transaction
  * @bchan: bam dma channel
  */
 static void bam_start_dma(struct bam_chan *bchan)
 {
-	struct virt_dma_desc *vd = vchan_next_desc(&bchan->vc);
+	struct virt_dma_desc *vd;
 	struct bam_device *bdev = bchan->bdev;
 	struct bam_async_desc *async_desc = NULL;
 	struct bam_desc_hw *desc;
@@ -1030,6 +1167,9 @@ static void bam_start_dma(struct bam_chan *bchan)
 
 	lockdep_assert_held(&bchan->vc.lock);
 
+	bam_setup_pipe_lock(bchan);
+
+	vd = vchan_next_desc(&bchan->vc);
 	if (!vd)
 		return;
 
@@ -1157,8 +1297,12 @@ static void bam_issue_pending(struct dma_chan *chan)
  */
 static void bam_dma_free_desc(struct virt_dma_desc *vd)
 {
-	struct bam_async_desc *async_desc = container_of(vd,
-			struct bam_async_desc, vd);
+	struct bam_async_desc *async_desc = container_of(vd, struct bam_async_desc, vd);
+	struct bam_desc_hw *desc = async_desc->desc;
+	struct dma_chan *chan = vd->tx.chan;
+
+	if (le16_to_cpu(desc->flags) & (DESC_FLAG_LOCK | DESC_FLAG_UNLOCK))
+		dma_unmap_sg(chan->slave, &async_desc->lock_sg, 1, DMA_TO_DEVICE);
 
 	kfree(async_desc);
 }
@@ -1349,6 +1493,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 	bdev->common.device_terminate_all = bam_dma_terminate_all;
 	bdev->common.device_issue_pending = bam_issue_pending;
 	bdev->common.device_tx_status = bam_tx_status;
+	bdev->common.desc_metadata_modes = DESC_METADATA_CLIENT;
 	bdev->common.dev = bdev->dev;
 
 	ret = dma_async_device_register(&bdev->common);
diff --git a/include/linux/dma/qcom_bam_dma.h b/include/linux/dma/qcom_bam_dma.h
index 68fc0e643b1b97fe4520d5878daa322b81f4f559..a2594264b0f58c4b2b1c85e243cad0d5669c26dc 100644
--- a/include/linux/dma/qcom_bam_dma.h
+++ b/include/linux/dma/qcom_bam_dma.h
@@ -6,6 +6,8 @@
 #ifndef _QCOM_BAM_DMA_H
 #define _QCOM_BAM_DMA_H
 
+#include <linux/dmaengine.h>
+
 #include <asm/byteorder.h>
 
 /*
@@ -34,6 +36,18 @@ enum bam_command_type {
 	BAM_READ_COMMAND,
 };
 
+/**
+ * struct bam_desc_metadata - DMA descriptor metadata specific to the BAM driver.
+ *
+ * @scratchpad_addr: Physical address to use for dummy write operations when
+ *                   queuing command descriptors with LOCK/UNLOCK bits set.
+ * @direction: Transfer direction of this channel.
+ */
+struct bam_desc_metadata {
+	phys_addr_t scratchpad_addr;
+	enum dma_transfer_direction direction;
+};
+
 /*
  * prep_bam_ce_le32 - Wrapper function to prepare a single BAM command
  * element with the data already in le32 format.

-- 
2.47.3


