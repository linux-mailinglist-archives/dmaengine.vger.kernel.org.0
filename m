Return-Path: <dmaengine+bounces-9601-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGzXEyFjwWn/SgQAu9opvQ
	(envelope-from <dmaengine+bounces-9601-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 16:58:25 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B6D2F732E
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 16:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 701AC30C5EDB
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 15:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2CF3B3C18;
	Mon, 23 Mar 2026 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JJ4wsOB+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HsNhcd/t"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05A5285CA8
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279055; cv=none; b=mfcfD9nUB4OJBkTGEuc0qtNa5th2mmXXxEZggsvHrjEIggVLanhnCnHycBbPjKXznaWfoiC4DmqJt35sT5EVgRBisnHt3mCR6PZE9WkhQ9lcIDpSLgxpAvRQvV5w7lcro+D6zauVO/ONiwCa0JM7nuNUXnp8rx4XZq0DtnHws6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279055; c=relaxed/simple;
	bh=YERqA6ytYIBXeEnEVHuNkc6pRniKdplpfqUBYqgG5Qg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VMeCnMGp6ZrDfACUFnj+iWVJfeHj7rSvcyxDotCe0MOg6qrA8hryEumsjwJi16/B5Y2cbjv7UejHSx+Ep0K0aNbK1PP1WfofFAn9nVZ1M4rMF+0QlyC20lacc91hnXnilEoGpLSRWbO1Pzc19HDspm6diUPTkidlcg5l+pgPsZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JJ4wsOB+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HsNhcd/t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NFGsVD2829447
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YJhp9RjB1CYlks4dixIKSaB1cc2NAImnrh4QNBeenlY=; b=JJ4wsOB+77hQGkT4
	OsVIpJH6Z6ihv73m/qD/CdFRhfTbvuCxYxDHHD3fthwlbL/JTfPoGmt1Bjsl11Wf
	B3H0txhv00WzhQCUH7w8FMRq4HzaXF3jT0oijnI4tuaHXZjBYd3TwVEBwWDDMf5L
	8ROzpiBVhkX8jWxsrKuisNt3AaYNr6yvrW75ILkfEMJfS0PCrE/zQMgEbmTpAmtk
	8PjnTEgkjx1uktE/5J7C6FqnXGBxCqkhE3Jby/HXilnQ0gxT7wOzvGiShmHpY/MP
	oZx5J9lIHxvKwAoNihpmrA6nKeV/I/DTiFRqAxCACBjc0DclTUAbF0x00BajZRlx
	aK/BRw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d35r20juf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:17:32 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-950d3d72bb5so6171328241.0
        for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 08:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774279052; x=1774883852; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJhp9RjB1CYlks4dixIKSaB1cc2NAImnrh4QNBeenlY=;
        b=HsNhcd/tOt0R+i+oEzhFhT1kGgPbxwEx4B33XU11sUZRJxtmC5VERKaV6CWVzK6Lx/
         gKVNuSZqbZsz6DCoC+DOUzJvDpXLZalr12KwEHQqkE+Hd6/8GaPDJr2q8YUIbNOWugmC
         SvpY7AQzEaomukV8CyFbQCw+Se5IknKHApO3p9fOZ81X2iSM9LjovbfogITgaDrvs5wm
         LdiXQldIdEybfc+tUlwx+F0oMsV9Jd+hjmhuHgDb5idIeWraQdq/9XW9sURfUOCCqrfP
         jRjhXsbYj28cI3ix6pd8o2kIiLxQwiSKJkCMFhoZ5ZCa0LNh71mzBFQuyh+uPCONWVgx
         I6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774279052; x=1774883852;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YJhp9RjB1CYlks4dixIKSaB1cc2NAImnrh4QNBeenlY=;
        b=qRbLA30WgwePoAcIauIlPdWZ5jURkcmDScXoiWxLNVThTtvWhdfxDpfDDkTOz3kPDh
         C6ihdodYF14D4kt4I7clBNV52Z7ZssK4qmibuLw+CkQ7iBwJy25STCtFeZyHZfN5oWFn
         yCpvimtt3WtkoErlfOgvqkL7CQiudB5nBxMxbg7ze/qnr+Xj1zzuqv4W6ptM2t9z/P99
         lcWKTEtURNtyjVA445V6Ttp2IdIBHbEhO/lW1/vvHACGh+naAfzZ69S80FvKQ2JYLmib
         Q0jLFzrwuuSaA6lKy2CqWrZU2fAAtBuCD/4xuhNwzavtO2WWboWN840QHM7KFXt6iYIW
         9sxg==
X-Gm-Message-State: AOJu0YwvZCb45QX5saykfl4A+sFpERkQ8Sbg0sn7iP9bB0XG2VU5nvez
	qzG7pnf9c9QbLFmdvUIc2H1M8ml97SzAZp3LjOb8C3tVE3ac6UjRC7tKP8u1mSzzOyHWHHOOwez
	AtvJDzOKEk60xKeLZQHBXwzPulaTM6LqueoMwCHZG4l/7Ik7RCuokLpL3r6yXgDo=
X-Gm-Gg: ATEYQzyNVYIw8LfNhmN4eSaOUSvvy2xCPNfXxdhfvdltk/ZIRiWvuHx1u0JN+ZT971s
	AZvp6cOC+RZ01gOL12xgVESs65KgSDs8L2iWqHd4N/TrtVa0GZsv6LEoeyRWc+JHCZn0rNVu2/R
	6VMT9a4GVJo5utz3n/P7uPtN3cXcRmUZikQGm74PZutpwyvA86OBgrmB3x3uq8VCQw1ph+POP/W
	u/raEaSmQ8/RLDlIYDVOjvQ9QwKtvS5eMzGbK5UWZtCrv5lfDSTUp98yEKu7Sn0FTXyY7LKQeID
	p5ToWEkP/lVhrW5Ql3++dUzQPpJJJh1fjROwJ9grmB1+SNSosNY/AjkTyHrjxBAzIhCIkHaO02R
	xUtI31yzRmfHunMTZq53CSWMYGl75wWF2pzY1/NnOuDto3mFi2nx+
X-Received: by 2002:a05:6122:62a6:b0:56c:ca03:b668 with SMTP id 71dfb90a1353d-56cde32da5amr6695148e0c.3.1774279052248;
        Mon, 23 Mar 2026 08:17:32 -0700 (PDT)
X-Received: by 2002:a05:6122:62a6:b0:56c:ca03:b668 with SMTP id 71dfb90a1353d-56cde32da5amr6695092e0c.3.1774279051692;
        Mon, 23 Mar 2026 08:17:31 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:f9a0:d7e2:7eb6:79b5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bd923sm35936993f8f.12.2026.03.23.08.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 08:17:30 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 16:17:08 +0100
Subject: [PATCH v14 02/12] dmaengine: qcom: bam_dma: convert tasklet to a
 BH workqueue
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-qcom-qce-cmd-descr-v14-2-f323af411274@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4421;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=YERqA6ytYIBXeEnEVHuNkc6pRniKdplpfqUBYqgG5Qg=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpwVl7umMQ3GnFqLlg71VARhQ6e61Rs2KOgtl+t
 o3DQS+zhcWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCacFZewAKCRAFnS7L/zaE
 w222D/9kYrdTy6/L2fho2KYzkGBtX7TQ4WeNPeZvXAVqu/R8LiwuMDunjPLVWIMelX85xqJ1n+z
 ydTwhLSYezv9MulGhZzh8qpHwS1Gqo0bKBtOmT1mztgH1SSsDKvKpPhiNKiRRB7rleYzgYloxBB
 Vz7+oZQsc8wHQ82NIyacWFzBfMvsi/ZmPba3sroND3ekJrKT0SsZ649akSETp2VLppvO0fOJUxH
 EvkgzxJ0RO5tjRCopYWfXbRAxZLuJ+eflsvg/YZ0nYKnIosIZgGBZ6x5j0F1rpyd9zxfqTzg985
 MN+SOfqjroS9vT64JMKgF42V+hrE23pl403wLXl1wF1ZOQcIgR8jk9YNFrqUzMaxXMKvw/y3tYI
 CivzQOX0Q+coDD19AwSmmxwlKj6AX6sB+mvAB/pbrrj4mr3mA0rp3UaDh7bhl2ecBwAufqV68+7
 8/s+did9HpDDrm/EHceTQuvSeANHgVJUCXBx64zSWzdRUGvdELwe+9pCNgsUOPIH/KkygNLRcCM
 ye1O+mBaeBIngMQBV/ukt8Uc1P3SnaE+Q4ESw1sEJURdq2htezUhIaxMePlX6UuGziZNrw1vCBZ
 hDsPpSn3/6HOagrF+GeaOj99gpIunAlRI9l1Yc4KZ2yOpdmowWWwCiVu1zbDUz6sCl39IyLXUeL
 d+pE79VcqEbMZ2g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=VvUuwu2n c=1 sm=1 tr=0 ts=69c1598c cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=u-biHsxzOdRIXVMzAPsA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: JAg8Bk2y6XMi4IypFczK5qJmh-EWpB1b
X-Proofpoint-ORIG-GUID: JAg8Bk2y6XMi4IypFczK5qJmh-EWpB1b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDExOCBTYWx0ZWRfX/uybF22NylzJ
 F+GtHIC5DLz1bh98t0a4qR3H25WsD2Hh7/ya3YLocJPft8dWFE8W43KEQSAUBGb1sVAHggNR0XA
 orBCUrlAwnVPciTShiQEA2dPHPgBIeImQn0P6W1gjP841sIb+wXX7XaLxF6oXtK4gorNpaAqvjR
 l/NtCqw0g6sHzZYa1XNoEZnJ+jLKwLFXZbddXt/hPFEVvo66BjAgVaAtya7tKV2yXt6OfpDkPHb
 JtV7J2RsvmBqsiCw/ZsHEJjQhmFqj6cl+Jjxm6+d2y5nOm6RhOB4eMJtO2sSONtER+CWovgPEzA
 2kP71KL6eIqvIWHXajfogozZqusgvlpo7RsJEjs4NoDTp5beoK3+o6RQfZ9vCSxxFB/ZdAb6nIT
 29kn51CRCOhXJXWwsMuALDsoGVe8DACYYmH8DGA8aazafGiNhPYbCktwBXd2jFb6PP7bT/+UY2d
 StnRqE4EPqjmk/TiIbw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230118
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9601-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: 53B6D2F732E
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
index 19116295f8325767a0d97a7848077885b118241c..c8601bac555edf1bb4384fd39cb3449ec6e86334 100644
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
@@ -1358,8 +1358,8 @@ static int bam_dma_probe(struct platform_device *pdev)
 err_bam_channel_exit:
 	for (i = 0; i < bdev->num_channels; i++)
 		tasklet_kill(&bdev->channels[i].vc.task);
-err_tasklet_kill:
-	tasklet_kill(&bdev->task);
+err_workqueue_cancel:
+	cancel_work_sync(&bdev->work);
 err_disable_clk:
 	clk_disable_unprepare(bdev->bamclk);
 
@@ -1393,7 +1393,7 @@ static void bam_dma_remove(struct platform_device *pdev)
 			    bdev->channels[i].fifo_phys);
 	}
 
-	tasklet_kill(&bdev->task);
+	cancel_work_sync(&bdev->work);
 
 	clk_disable_unprepare(bdev->bamclk);
 }

-- 
2.47.3


