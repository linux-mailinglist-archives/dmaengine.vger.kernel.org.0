Return-Path: <dmaengine+bounces-10944-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCQsOGWeFWr9WgcAu9opvQ
	(envelope-from <dmaengine+bounces-10944-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 15:21:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 847335D6506
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 15:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 112463037F52
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 13:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BA53FBB67;
	Tue, 26 May 2026 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EL3VlKhP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UQS/yMJV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB5C3D88F1
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801092; cv=none; b=qErqIZ47sdXpN74eXaenf5pRUIbzepwaa7fphzOEOS3g0+PJqRNktoanjZliQd8c0khMucOx6ONMb68RHusyeg+BWruVuT1aIxwG0UhaHocIn6Ia/CZimT7gOj1aWFpl7igR+BtTZdvq57K14GxqNFEe7KMfZBE+322I5z8/z9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801092; c=relaxed/simple;
	bh=W1SOKd2RIQ9nozxC+fLn2sIL5/s1so7KiyQzTPwT+38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lFFcA4AHCjDwCKzn+vbs31FWZZXVZgLFkDjSlN0iUAOfMjV/xw98W74v/bL/fmM9JTeXHhw/lLjRjrbI9fpdpF4P6khPoPcbNtClxyJy/DZTJObW5X9fYmFFIFWWPJrrpEfqpOHaY2u7HrE1vWuFrpBwkq+yOo44liCPcD5K1mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EL3VlKhP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UQS/yMJV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QCsPrQ2697728
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 13:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4MzlzgFENj0SGuc5BtzYXGLVYZCfinPwBm1XxV5rC6I=; b=EL3VlKhPKpTo8VtD
	DLli+tRTMhesH4IaeOloJm2olJfrT+88J4LsNG0YQgypjCEvqbRrc0MUsrUrvVTM
	LtYFwCY5AlRgSyriX7j2kWsROltLk2sP/Xq1zYwduote8gNdS/EsAe10ksAlNcN5
	KBj8qqx+CtWAEnp2mp225Q/FqX8ybuv6D4m+vqljxdvwJQb2+14bSvg+zScYSSqH
	4ezzgQpbBcCVt2q4dlW6DFNHez3WMXtn8VVTzxZZvitom8KobB/aDWZxA8DrvyqK
	9eUJAIbm00iontObpVKfkfCoLWjhwzhBWOYWFjEyrLNS942DMy7SJnJa4D4b6jno
	6S8Qug==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecsm03u84-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 13:11:30 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-636fce7dc8dso5503622137.2
        for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 06:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779801089; x=1780405889; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4MzlzgFENj0SGuc5BtzYXGLVYZCfinPwBm1XxV5rC6I=;
        b=UQS/yMJVR39QJ5wx69UTjVCJCU6jeGlnf0bAngvIk/3TlmG4L1pCqmtmEyaVLCpfNi
         7387NCuDIRT5p5eQJ5IAFSPsEDrfCLcQJF8EYM9mq1K91d0jEMKG/cJc4ut0hZj7PVzO
         daz0kpk4Dc8NjWbUT52/zg4+t5R/Dl7pk5AtdTQn+NL1NY6RyIgy+D8YIKlNiwVAFYTO
         xxeGDuTAn36Gp/D+tYkOKWtSJh/24yfibQ/H4LMO77C0TFmIdl28bHAvTjoydsNH4NmE
         5+RfkJII7TKPRlU/7A/Y/BYiEvJ8Eagdh9OuYR91ObIG++XdlIJiLR1eS0RAERF9H+dn
         Vz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779801089; x=1780405889;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4MzlzgFENj0SGuc5BtzYXGLVYZCfinPwBm1XxV5rC6I=;
        b=CZlasgjZFx17+u1PAqCuVMyHn4jNiHAHhVQhjKeYha3nnbvGGFgsWI9ymR2TKxRQyV
         OJuH7eYsoPqn8FKbf0jRbcZJQ/1EUluNVNTA7HcYHTuWQ0pCljBRUGvM+LmwnkrpdXMp
         Rw2NYQbZL/qD4MmgjGYrqUXXCXOP4mu0yuZyw+bpjv/w3GVNEntwhUNMUryzyZmhJ6TA
         FdNAfutGe0hgCzjl7ba2Uby1YJPGf2VCP7wDjJpFEHGV7FKumLi5feqQdBgEawVLf/yJ
         8IrHZJfXl5sgAy+pfqYNZmxFjlBKR+huMsfHUSEstCwXi5zjlqX4vVn/wyZQI/ZAxrHp
         pHSA==
X-Gm-Message-State: AOJu0YzGfat9IoU+rGCHlhubZuZTzsLGpyO2nPPw7jFgHGmcHS99n4nf
	0TDz2T/NV14TD1NBxcmE0pGJsAgW03JtZdKd74p/4s0jR57EUI5VdoJaYIRgM9r8OlPWynPQ0Sd
	WJsrIygrvBYcPesNHZOijp7cSYuvNIYQ7iydeBW5xoj0YFP0HHnRmk59xcXH2g08=
X-Gm-Gg: Acq92OEz8R6KUZ4fiICf6el5+SqxJLihsuoONKJqBEdKY+Q2bAUc7zGMZYBLi5j3aU8
	ulfGgH53ziWM9bxXuo+3UgQtkJRK6ILTs6IqayQikFuPWbXtExGdA8BSx3S/saIF8zWUOECpsrj
	j8I0XWxP4exRdAkwy/3kai9AtjRU6um0Kdl0uluc9lrMvJJ/943cg2+CDSWS344BJTWu5Mq/tRQ
	jd+SD8QXnkJU4ZahpJzUF6f4tJXQdgMcCj4keMGuGiG4FKuHcIBvRscsSz/u6UKKPrj2HsnfcH2
	r6Ukuoj041D6wSaAo1WLkJVElPxIrDnL/ILNkmjMgW0afAWe7VGLdHS/blXE6URKZc0vLZAT9Mj
	desV5RE2dUeu+OPl8MsHKWq9QTZpD/7+WoMHzolujEgX/NXD/euhVn61SEDK95A==
X-Received: by 2002:a05:6102:3e15:b0:631:2472:e832 with SMTP id ada2fe7eead31-67c7fff41dbmr8318258137.8.1779801089271;
        Tue, 26 May 2026 06:11:29 -0700 (PDT)
X-Received: by 2002:a05:6102:3e15:b0:631:2472:e832 with SMTP id ada2fe7eead31-67c7fff41dbmr8318181137.8.1779801088719;
        Tue, 26 May 2026 06:11:28 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:15ba:1d70:65ea:9578])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5e484sm34259426f8f.30.2026.05.26.06.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 06:11:28 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 26 May 2026 15:10:53 +0200
Subject: [PATCH v19 05/14] dmaengine: qcom: bam_dma: Add
 pipe_lock_supported flag support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-qcom-qce-cmd-descr-v19-5-08472fdcbf4a@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1530;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=XWQU2M8GNJi1hTXicUIAjauPbHJI4z5KvicdSabu0NQ=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqFZvsBil2ok+w4T6U//UrDGniLgPdz7SgFTDmi
 XqSwfkI+kCJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCahWb7AAKCRAFnS7L/zaE
 wy2XEACuFrcK2feOu+lrKAd8U6HtwFQlksXURX5scLbVJhJwrkfs+36Nm1ElbTghc/YDaixxI0t
 qTcdKbkQNAY1Lj0H4hwEMCVdQcclcPofcTtvt94EuA24riGm3o4z/kU0hOi0kMMftMSq02uJlS5
 CxMy9RaV5m4P3e3+OgX7e5ikeGIM/vmLAuo9Fz3pBtsSI+OqRNbhFEYm7XO27Up90UfUl/ul99/
 Qtj137V3CbapUiQUVCVKarbJ9+BvPMQD8xiwv/+4Cefb89tQmWvWFFJVarRYuU0l18ZJio1As/V
 csVRhBEeplMDqc9pbunOnfPUBZITMbOMcfIYv6y3g9VjjPpw8NzYRthGKf/1ygyPKzGHgThLYH4
 GNV/KrIZeZQztPmz0opQ+L11t5SRu3ua+jIs7QwWkcS+YEwMgA0lEfn3mEFGQOe/iqT51Dtbvuc
 GuO8bxp95l8fyY9N5MUaDhG/HE7IqertdXFEqw3Nv5P+RVfmeHwclBS9kJ/t647/Atq9nR4WK0U
 EX3eTxE+sl9lCyID2eYPB8me3Usaix0I2km7PtvZlLFHdCMUqSEMBPDKKcbaE3j6nvYNWAx5ta9
 YuRzKQmNzJvbXRMsNpX4CBReFikdaUvHy2TXG/WIbTVxZybsDRXb3sKfTC5SbDA9qGweBHpS9mD
 QFqiM05R4l5US/A==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=CLEamxrD c=1 sm=1 tr=0 ts=6a159c02 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=ZSnkYuKn9ZpO9KHknGoA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: x9IAOZJJ5x712BdfQ14Bgvxz09aqtkEr
X-Proofpoint-ORIG-GUID: x9IAOZJJ5x712BdfQ14Bgvxz09aqtkEr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDExNCBTYWx0ZWRfX+rlDcti0Hn0t
 mo+BvlO2No4hQIsYYWjZ+Wwotwal9pzbznQj1tCqzqwgewK8pRgM+0Gxm2G3yum/SYFWjkjhyMz
 Er68XszGAqCcLv6P9nPC8lPKV1WV1GrWNBEl+Lp7AvTWFj/8SFH7QkLnQI/5mbJySurTiGTA10Q
 KrixBjMd/xciZMHChxX8dLKjfSkiK6+6DSNGfjNrdhuOsM3kfqezawF+o5r1RxtG3df/p/LOUZ4
 FmEuWHTHPW2X8WSkfMOy8YUfn7GO/dZv6+/XuDyQy0ECCoA2lR6cdNGQLbTNaWooLlR1hWIrUoT
 l8gmvsJavHfdGA26Bhz+V2sFh27GYxuPAIhry5MqfTfBzKOAlFCTGh5XBYNB81QSOEsiBRi/BnV
 8qh6KG6qVb/6y03+3/fQh9jcz3wPp3K3O6g7TdEfDs6u9qjaOz9L4WB0vfxnV6N0eKafa8onY/c
 f3m/0Y1GTLEYTQYHiyg==
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10944-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 847335D6506
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
index 2129ff5261571581a2c086c13dd657dc63e16f90..04fe1d546be73f074c66c4a5712ad65717e10929 100644
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


