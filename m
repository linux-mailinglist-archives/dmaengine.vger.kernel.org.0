Return-Path: <dmaengine+bounces-9187-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CB7HA9u4pWmDFQAAu9opvQ
	(envelope-from <dmaengine+bounces-9187-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 17:20:43 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DE31DCA62
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 17:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F30AF31DAF78
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 16:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1590842F559;
	Mon,  2 Mar 2026 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ii+o15pJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O01K4u33"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBB04218B5
	for <dmaengine@vger.kernel.org>; Mon,  2 Mar 2026 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772467084; cv=none; b=XQ5Zye1x2zZWTr2OLmdiQpE2POPdq8BBuEhkG0Oy4jNNFWxQV7JPW0ZZn8UBRV8ebyQ330Bc1AQLaSXr+2R3xujQW+jk4IRMr9PSR5E/8wA8AfV6BCC4kl9tHW3G+3LheXHzmzpyEjtx9/Y30v9EUj8IpEohioaaYFH56METLEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772467084; c=relaxed/simple;
	bh=UUgEXylEiIfyENE0peCNzYmE4sxUi2nWK9Ajpi5BrrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=klnZZFNZjkg81V6QN8HxUEXl2MNO16VNVk8k6boKAJ/IsUY/vCasychQcP0iQLCyTajUwcjXaPannbSXa3Ww55HyXHlIGtWWmNNL7EU8vTkNcg9C/gLxI7SDz27sa1zg20o/+Jej/NLEUHpzuxFP0kw6F6IWRw5IxzlbYBq+aEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ii+o15pJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O01K4u33; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6229JVC53741563
	for <dmaengine@vger.kernel.org>; Mon, 2 Mar 2026 15:58:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UPKupKC1xgRq8szLkSXUnMuGW4ZDJHNFE164RxCwkP4=; b=ii+o15pJA0ObdYt3
	nGfXs1wAil3n4EBCqhUko6dV5l0WXWS9DsGA+IP3l7zkNx9RRI4+6J5OH2RzJV6i
	qQYP5hNh0i3xWwtSnUwHV5uO4K3igZc30yF1/JKM8P4jJrlZVgUBwfFJ5J8Z+jOG
	TlX1Ao3gc/YS5XnSKhcDon5svWi1KeUpUKCMYhznFYgBjm6RS3FnkSqfuDd1CFpt
	nCfjNHDwx80Kj4qul4aSPTkB0Xe3vron3l7GiaBppDPBzOJF37qLuQMgS9ffsWZT
	pPnm2JXAu29qSr8ftw1n8jGyHwjyps58l7jUQI32hTxQaxLFxCHCw+KZTz9e/9RK
	HQQLrg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn7trhbcq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 02 Mar 2026 15:58:01 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c70fadd9a3so4608128185a.0
        for <dmaengine@vger.kernel.org>; Mon, 02 Mar 2026 07:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772467081; x=1773071881; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UPKupKC1xgRq8szLkSXUnMuGW4ZDJHNFE164RxCwkP4=;
        b=O01K4u33QXvOZoBfYNKt+U5QNadtjYI0nVb+t5hfsxbaEelK73G3GOAmv5YMJtZJNa
         59dZYWR/2l2xEp9jaXsXS+h/9wMyGevxhisDDzGECWzfkKCjubrl9ClrYfyNtzzb0eJQ
         6072Igr4NBa9+DZxjYavsyQNIcOsq2Mxyp1GbKr0zP3EcQ+MLGtg3kVWq1Vc9nJfgAbo
         uZtUgz+jSaXuCps+OOUijnt4sGDiC9wTLcYZOtvZI8p+hij0N1U1dpI3cCX71x/kGAHh
         IGk1ain+iJwkY3LPudRca9XHI/zpDVWrae0rdNxmfepJRaGLr9yKF76/0HLA/ZJJpJeD
         zG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772467081; x=1773071881;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UPKupKC1xgRq8szLkSXUnMuGW4ZDJHNFE164RxCwkP4=;
        b=Vggsbdo/81m1iy6DjcEoBKysBnJsu0ruYIOEKG1B8IYyKYecTckPp39Ab/g2TkPsPt
         MNC3Is2Gnkn63bVz6CIzUw9rnibXd8lQ40nxQHS68E/Iafs7A52paxX3NPETVa7kEePK
         7T2Mdd74nPB5DQt1c2CsV4TmQEcLJ7KYxvjTdnmFNr5r9cJbf6H1P70yYhGUnV/4e6EQ
         bc1MnUbFkL0p/VCX3kKw2dagw8dS+tMc8bDC/QPPlSLTBBPlZ0fKs1+isf8rTK5wD29h
         K0UM9OrY90+Bbzg6osI8n7IjY+IJHMrLWeH7EWPQe5tdOLNLKCpHIA9X3mWg/4zFFPZb
         2L+Q==
X-Gm-Message-State: AOJu0YxWqjI5pYc5cYEkBahR1xPDAArq7FrhK1ItQ2c1QWeLcqqd0unf
	b1HB+DUs9AssEjtRrQdvSATD5i/ZSFNuY5lO4c/broa/uazalAV3J9VjLUU1Ik5wwlI/4YnyuY6
	hyY8RXmbk1erh1byyWNNjVv3Ph9f/sDBvJ3tSxbM6e8B/ve1YV7IJFiI9KBOd3fc=
X-Gm-Gg: ATEYQzyv0OqdqJCCXTJM5qtsVY9qjt1qpmJOroCY0kTfEXYvLIsxd1whTEcw9ay/E/v
	FMJUl2TkcV88lhDx+J+2lVxcWPJY4uZoEurIYQlV28cARPQk3HYYjE/p/f1FQcWc+H5Aa2HLDhd
	r2HxvSL/CcrOSBNEXigdxLnXzP4ttkMTRwPVmRTNufrtWRXVN8xyBhYchpc91jDt7ujtTujzB0L
	MBplxyhz3s30CLLjRcCVnSKKOER8fT7k7urtmHFJL0pSQpwF1LCEcjEhu1HTw6eOu3EusQMGjhl
	LhImwEdbKfXnJQTSwG/fKqKZcFr/nFzkezA8F6fO2tkA60PDNmXSRX2UwCdyDSQ6rIz/OVapfNN
	PmA5pBbxZZXcZE3eTA9quDhT6RCzgDszPjdsQkmlhaLTAsGkNYCD+
X-Received: by 2002:a05:620a:7118:b0:8cb:4059:a90d with SMTP id af79cd13be357-8cbc8e50bf3mr1568265185a.38.1772467080575;
        Mon, 02 Mar 2026 07:58:00 -0800 (PST)
X-Received: by 2002:a05:620a:7118:b0:8cb:4059:a90d with SMTP id af79cd13be357-8cbc8e50bf3mr1568258085a.38.1772467079863;
        Mon, 02 Mar 2026 07:57:59 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:87af:7e67:1864:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b41831easm11282438f8f.12.2026.03.02.07.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:57:59 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 02 Mar 2026 16:57:25 +0100
Subject: [PATCH RFC v11 12/12] dmaengine: qcom: bam_dma: add support for
 BAM locking
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-qcom-qce-cmd-descr-v11-12-4bf1f5db4802@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4900;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=UUgEXylEiIfyENE0peCNzYmE4sxUi2nWK9Ajpi5BrrE=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBppbNuYzNnk2eJGRt4JyOLFUae7n6EGdPMeWxfu
 miC6fIYmfiJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaaWzbgAKCRAFnS7L/zaE
 w7F6D/0ah6PwxRWwRZZZ5QK1V24RCKtmj7bJS9c2b+P7QDdfyd9Axw1tX6IBQOeiU/H6d76yCCc
 FKwRTrSdvxnIMCjgyz+F9zyo98CqyeY729UpSZso4Aix+B3ur0stcv4j3I/Sjw5S2L7jXkUfFXd
 dDwOq52o2hvUnwp/Rs1xWulqb6yKgesa46m0fCw2PCA8PcKYckNMUiITaITT2Rz9Hvtr9PqAbf7
 oU1lOAi3+mCzJBcVQ/GJSyl3lSAmTeYeRv7JdoEJEnVedQ9LXTGJwmVvjBNt5QGOWov0YJT4mxI
 qWAXfRZ6/qbB7taKE0xR/pujgrZlThSqp2kiIIn58N8VdUFbPHVwU68FRP7gScBFenmwgmev7t3
 0YwNvoniDq3zLervKJu1fxgZcUkjN5RHdNhldom0bhU/KF+/OH1ubzRLLppW0Dx6djvopjCWSy7
 WxJZL9fkwwucP7wBiJfZju3J3UvkjLVe2K8ebI1w0PVGGo0cnYq+vQkd/x+bR6LPkq9gwPKv0J+
 +qwk8haYIqtaArSVdx0Cj+j+t+qMwcb9yWvcxzD2DoVlgA7G6LaSBJF3fWpHh2ZPETwmPW+udNF
 MfvjZ4/g57Z3zSwVWsn9D0xGM8YHTmTSP4nZQlfFdXF0qGcET+J+dzK/onXhMMod+UneCCi3R6y
 E+lmkkjCDmtGdcQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEzMyBTYWx0ZWRfXx3WjgtYdsBDZ
 f8q7Y55v/ZJqTTMkSslx0Q8K7UFtHGmr/hOsoqljC3tukLWQvFrF1nOC/xQ7lAjtB0gN64A8qEW
 VEWA2AEMV2fhgkp9Lz3gpemanZKAawSVqsLlTEqr18tTgPF2rU+ulZe7DmGN7ib2aOne18CI6R8
 tInmM6pLTG1kipG1MsyB5rVuE3ZHlrtA2LpzKxwBdYlQXSFYJ4T7A6oN2QLzsIVe3stfkpWFI3O
 ah9qc5pz6sIdnQGwyU1WBA7sK/CftNUrM7dxVtfP5uX+aftrihXU8xTGx308q0FSO0VEXzcFcmy
 GKBWwwD+RAceGiVbB/xRSJ681X4QESkd9NhCSQmxnaIxCIr1h4HlxT3qQp0ISJmhZ08AnEJ6Ap5
 on+F12jB4jXwnqdzI3d8TxYGqnTFwtromS3iVEloIGhQkX5WO3zp/KgL/4LUamtvzSlcBBnJmdF
 inmbBrb0+vsCqSzdK9g==
X-Authority-Analysis: v=2.4 cv=TNhIilla c=1 sm=1 tr=0 ts=69a5b389 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=KZCnMsYHACgmd2lUPBsA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: e79BUeaWc-biQxpIZb8S9m-xjqzvpuXC
X-Proofpoint-GUID: e79BUeaWc-biQxpIZb8S9m-xjqzvpuXC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603020133
X-Rspamd-Queue-Id: 61DE31DCA62
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9187-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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

Add support for BAM pipe locking. To that end: when starting the DMA on
an RX channel - wrap the already issued descriptors with additional
command descriptors performing dummy writes to the base register
supplied by the client via dmaengine_slave_config() (if any) alongside
the lock/unlock HW flags.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/dma/qcom/bam_dma.c | 100 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 83491e7c2f17d8c9d12a1a055baea7e3a0a75a53..b149cbe9613f0bdc8e26cae4f0cc6922997480d5 100644
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
@@ -391,6 +395,12 @@ struct bam_chan {
 	struct list_head desc_list;
 
 	struct list_head node;
+
+	/* BAM locking infrastructure */
+	struct scatterlist lock_sg;
+	struct scatterlist unlock_sg;
+	struct bam_cmd_element lock_ce;
+	struct bam_cmd_element unlock_ce;
 };
 
 static inline struct bam_chan *to_bam_chan(struct dma_chan *common)
@@ -1012,14 +1022,92 @@ static void bam_apply_new_config(struct bam_chan *bchan,
 	bchan->reconfigure = 0;
 }
 
+static struct bam_async_desc *
+bam_make_lock_desc(struct bam_chan *bchan, struct scatterlist *sg,
+		   struct bam_cmd_element *ce, unsigned int flag)
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
+		return NULL;
+	}
+
+	async_desc->num_desc = 1;
+	async_desc->curr_desc = async_desc->desc;
+	async_desc->dir = DMA_MEM_TO_DEV;
+
+	desc = async_desc->desc;
+
+	bam_prep_ce_le32(ce, bchan->slave.dst_addr, BAM_WRITE_COMMAND, 0);
+	sg_set_buf(sg, ce, sizeof(*ce));
+
+	mapped = dma_map_sg_attrs(chan->slave, sg, 1, DMA_TO_DEVICE, DMA_PREP_CMD);
+	if (!mapped) {
+		kfree(async_desc);
+		return NULL;
+	}
+
+	desc->flags |= cpu_to_le16(DESC_FLAG_CMD | flag);
+	desc->addr = sg_dma_address(sg);
+	desc->size = sizeof(struct bam_cmd_element);
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
+	if (ret)
+		return NULL;
+
+	return async_desc;
+}
+
+static int bam_setup_pipe_lock(struct bam_chan *bchan)
+{
+	struct bam_async_desc *lock_desc, *unlock_desc;
+
+	lock_desc = bam_make_lock_desc(bchan, &bchan->lock_sg,
+				       &bchan->lock_ce, DESC_FLAG_LOCK);
+	if (!lock_desc)
+		return -ENOMEM;
+
+	unlock_desc = bam_make_lock_desc(bchan, &bchan->unlock_sg,
+					 &bchan->unlock_ce, DESC_FLAG_UNLOCK);
+	if (!unlock_desc) {
+		kfree(lock_desc);
+		return -ENOMEM;
+	}
+
+	list_add(&lock_desc->vd.node, &bchan->vc.desc_issued);
+	list_add_tail(&unlock_desc->vd.node, &bchan->vc.desc_issued);
+
+	return 0;
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
+	const struct bam_device_data *bdata = bdev->dev_data;
 	struct bam_async_desc *async_desc = NULL;
 	struct bam_desc_hw *desc;
 	struct bam_desc_hw *fifo = PTR_ALIGN(bchan->fifo_virt,
@@ -1030,6 +1118,16 @@ static void bam_start_dma(struct bam_chan *bchan)
 
 	lockdep_assert_held(&bchan->vc.lock);
 
+	if (bdata->pipe_lock_supported && bchan->slave.dst_addr &&
+	    bchan->slave.direction == DMA_MEM_TO_DEV) {
+		ret = bam_setup_pipe_lock(bchan);
+		if (ret) {
+			dev_err(bdev->dev, "Failed to set up the BAM lock\n");
+			return;
+		}
+	}
+
+	vd = vchan_next_desc(&bchan->vc);
 	if (!vd)
 		return;
 

-- 
2.47.3


