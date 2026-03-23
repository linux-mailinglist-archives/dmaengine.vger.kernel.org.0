Return-Path: <dmaengine+bounces-9609-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDs3HRZhwWmaSgQAu9opvQ
	(envelope-from <dmaengine+bounces-9609-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 16:49:42 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0CD2F6F99
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 16:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8FC033F73D0
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 15:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B4F3C6A51;
	Mon, 23 Mar 2026 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FUxOJawe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bBCsDElq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FF93C6A2F
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279081; cv=none; b=NB8HFKrDCkYqviIZPKsSUwbBRRGzZwtDWvLePivgB3IOLvKxXTJDYgcMD1EXW48O2UyKAY1n0OMGyjDdZh/8Jxkq1cbDTLqGcRWn/NRoC/Fl+3mL4TDrvZ7jHR2zHjYOced7jzBDIZFFGX0GO5+F3gGJpnRBbOJWZB7C5GGXfCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279081; c=relaxed/simple;
	bh=FnVBtOe0OnnBy34d5WsqwWSUvkeiYQ93/vJc1qwp/2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b5INUAEN4Y7MpHeVVEIizYt7/nmLcPkFJad5Djr0QWQo9H/kRsr22nQh09nY7VsyxFKIRFKm9yigmMqB82V84Ob57XVG19A79DJc+8zTJIbB7+s8vgbQwOJGw8tAGiXBN34PCLof0PpVESFujp3gTvHwgSZfcsdxH1B/Y9lxUgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FUxOJawe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bBCsDElq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NFGYpQ3589280
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MnBQFcKPOgFHzTGJJB4DToRykxT+JvIdZWyKHEJZL1c=; b=FUxOJaweHYmdSkal
	kIWOp5Pmy0Cx4lcl9BR8gL1sKoSV7P4jxSxzu7/jAiDB64xpnpggU3+mamQSpmcu
	aXdHmjfR3j+1VA3YvroES1FGGC4J5eiHcKrDFT2QHdq7wo+GF3jAdfn/3NofPMef
	tB2KGaaQvX2ohL5W1Yit/GAyRyjFLDYT9dOO+1r0b4Gt6tUZkpmpIRBAzFimDdG4
	3UzR7P3UItRCxw7dFgtu6E9z8JiT8VsCC7Lony+KkR324HQSxg3xe8hOHe0662g+
	0JzYfgvQ8FF7T2KGulydhcJpQJ2MlD7KR9nwKPLMG/Hb+D//ICk8W/tf+q0rvM5P
	CMichg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d37a0g5v0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:17:59 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6028039f3e0so1802580137.2
        for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 08:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774279078; x=1774883878; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MnBQFcKPOgFHzTGJJB4DToRykxT+JvIdZWyKHEJZL1c=;
        b=bBCsDElq3lgcVNp8kJpVp/yPy6ykbal8Riv/h/PgcPz0HsNqhUjZQ4vq9Ead5KpFq2
         4apXbNACxoP4CrLuZP9zVUAip75JsMu6Qrrbcm+lnRvh9pb1z8wbDxxVxvvbMItrbpXu
         6kxGYpcsGdigSQKT2SXEJRi7wE1yfQUjy37zB4lxbwjHRJ9XgNpP56eOvnkpWgF9DSwG
         fq/HeCDNc7TFSuzlo5xCIKpertRaz1Od4IjVUIHieWHTZh5R2MUJYFHBhUuteoKOeXcY
         NCTqXoue9PYszNmLz/N/UPkagIvLhWpQb9QnmaL5iW3idhoofakkiOTcwuP0ZZN8jj6g
         wrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774279078; x=1774883878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MnBQFcKPOgFHzTGJJB4DToRykxT+JvIdZWyKHEJZL1c=;
        b=a9ZbwC2wkm2/z7GpLmqEQlHS5ohDcXeCMzT3UCEe1CvIaPN4C3AoyFKSx8tijeDQCX
         41E9FPMgtBrckzbHxUOzYBp85tCQUj3zWBOwymd9cpaOMv1XhL5CURG660xKx7J4fjAW
         qjn2XdiBZT7m9O8nAbWi87EPMCWmby1kDP0Kcda6/mNgL8zAGmq8/EEeiukNmAeh0V59
         xcJrtq4LhArcSjJmXK8mMjbpAMiCyiFU2fywrsJP2ppXZu6gMUMu6XEgACBqj7ZbCMJT
         nsPM9Q2j2RnT7/fQ2BkVkyvhPlvVhRDQWCw+VF+8a4elcCNB+FO3wLVX/t5cz2HY/VDe
         uTig==
X-Gm-Message-State: AOJu0Yxi0IJP5FyylGTeCpdKP3G488yCG/AcNbydc0/+SDa7TZK1WtKK
	qIUD4lU+IGlE6TIOOrIJBmOMpg8m6GWJHRb4aoQxPglxdk/RO//5tTRXIU3/ijTVl4FxUv34/PA
	TOabJnLwnCKG++8Mw/Sl2iIBP759akHyPhEsn7p0YzcIAAXiFs0M/inmRWzvuNNM=
X-Gm-Gg: ATEYQzwM9mOmWc+0ts+5t4MoqPufpcdIqEZIIgvy4kfbk1pVg6DAJFRr2DC7xr8C6mp
	fukAlB4xWOInG6fockvQYSBIwlcbSlk13w2ovTqHS45ogUid8w7pqjYrrHKmLF83v7Gk+9cnLIR
	H8G5exVVFkpnH5hDVM6euj3yw8kfckO4tloqh+XSMUCexcyNdwl8n9+2waU+DYs/1cYv8KqmlfH
	o7OtxHM8xtJGKRz0He8fA4JUg9j5vx8EXV9JvVxraB8vHAYLyXgZkC+KvwU4tujUJvoXl+6i0qj
	UCZrdVZF9LaaZuaYqlzon/xC42L4zK/Kpduti3pYdGe3J+D+/XbyAHt9MFwgRgB9Ldic6ey/vC6
	rwgJRMVGNn9Glcj8U7cwrh9i+hU7rFZfrC8lhiQP5MLXaMhuBOQVt
X-Received: by 2002:a05:6102:605b:b0:5ef:2457:8015 with SMTP id ada2fe7eead31-602aed2cf91mr4164278137.29.1774279078513;
        Mon, 23 Mar 2026 08:17:58 -0700 (PDT)
X-Received: by 2002:a05:6102:605b:b0:5ef:2457:8015 with SMTP id ada2fe7eead31-602aed2cf91mr4164244137.29.1774279077982;
        Mon, 23 Mar 2026 08:17:57 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:f9a0:d7e2:7eb6:79b5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bd923sm35936993f8f.12.2026.03.23.08.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 08:17:57 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 16:17:16 +0100
Subject: [PATCH v14 10/12] crypto: qce - Map crypto memory for DMA
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-qcom-qce-cmd-descr-v14-10-f323af411274@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3159;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=gRGqUxioVpJcY9zBfeIZn1vIilzfanwkfyseaIOaQFk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpwVmD13r2Am7+SmM6Nm34ZCXhyvI5Vew5D7Iar
 vEE0IzdsEeJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCacFZgwAKCRAFnS7L/zaE
 w2EcEACY3fCs3Yh5lWl3/XHzMLQFZNwKQZ/k9C2OXOqzLPfweIjH6GOVNQwsNp7Gs6yxHSFYAx/
 XR26vYVkhBIP8DpR/mYkQNqvp189NvAsr3PGrt4xF6Iyn/CuXrbpzoVZ9ZXgwRXVVDBrhGWrKtu
 mdSTdIqJau2Q0n4UGzjYlbhGRncGrIGjqqme+2Fc6+dwuE0pnDS+JJ9OO9uTyuhvA5PWMcDc1L4
 XMwax416HRKoAe+ffnVPKgKEQv1VCDDwFt444d3cu8G/T9vN0k+T09cQ9c3IssydxWAc4xj6fG9
 UMSFSxfMQVNcjprHSi+TJUD1LCfbf2J4VlK3hkHA+ZZxBVkiF7aLQRW+lnZz+n3mro4JTu1CFBA
 tzksi1CUKRerz2m6FywZ1tZW3VbDipZLxUX5SZWkGwYa3XU+1kt/J2+Goy8vvJul5pKqCUyGkJW
 E4CN2LVhh6G4UVtumezbbh9zb+0WWPkLwyyi1Q3kXqiD/3w0ZYIU8GMPjEA79ADG9fJPXYl+u48
 ed3FS4ubvxZtPgoU3EW0hZOXb5YTnoA6I6/W0IoynuvQQB1XGMIbZbO5dKpZ1b+NsLJHxEomgdy
 vnOQAJgvmTj55RFUQHqAyYe4xSw1hznvvNiI/B2hwntLNZ5OUSud8cSRc1eNd1/49O4zkj9yzIH
 zipi5FcHGyAi/PQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=GIIF0+NK c=1 sm=1 tr=0 ts=69c159a7 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=76fuQ0JqpD8MvifAs1cA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDExOCBTYWx0ZWRfX7SR/HhnB/DfJ
 eV4heSL3jtmztgmVnwy/aZauMoBlG7ekJOn6wBDRgz1ZX8b/J2NYdYb9lJ4biPhaM2GtDkmy0A0
 iMhCdCWR3J9dIcRNshkEus3R77NQVN2F+2alPVqj5gN9fSw0lA8zzdqHHj0JplBYgvDa4YTiJ7g
 wjYlae67rtdAxqsALNR5KBA0vvBhladVp7TtqnQlx9ts6F+QSvZTppJBcdDUPwoElxMo4R7k0KP
 Ji42RN4xHQoAxtJ1805T/U+nskxkdlhIW/tzLOeZo0a0UzCoSsYL0gTt/EUvq4XenzNd4qA0zq2
 M6x4Y8wiVWk0emQ3fKZ5LWLPtDvjlox3dVs7jGYTAlOjxvGFl6R7MJrYqIxCZK5oTFDTeOEWo3f
 6IS84ANFID4xyJx74XFEqY0j66/XDBhpudiK6EmgWOmpCLYWfY4HK2FSry8ZVg76rGymqefSGaG
 4xsv7VzjhRr0TAmuSwQ==
X-Proofpoint-GUID: iElyjl48tvxZcRn1kcJVys4Qt9Y2Pyq1
X-Proofpoint-ORIG-GUID: iElyjl48tvxZcRn1kcJVys4Qt9Y2Pyq1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230118
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9609-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,linaro.org:email,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: CB0CD2F6F99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

As the first step in converting the driver to using DMA for register
I/O, let's map the crypto memory range.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/core.c | 25 +++++++++++++++++++++++--
 drivers/crypto/qce/core.h |  6 ++++++
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index 8b7bcd0c420c45caf8b29e5455e0f384fd5c5616..2667fcd67fee826a44080da8f88a3e2abbb9b2cf 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -185,10 +185,19 @@ static int qce_check_version(struct qce_device *qce)
 	return 0;
 }
 
+static void qce_crypto_unmap_dma(void *data)
+{
+	struct qce_device *qce = data;
+
+	dma_unmap_resource(qce->dev, qce->base_dma, qce->dma_size,
+			   DMA_BIDIRECTIONAL, 0);
+}
+
 static int qce_crypto_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct qce_device *qce;
+	struct resource *res;
 	int ret;
 
 	qce = devm_kzalloc(dev, sizeof(*qce), GFP_KERNEL);
@@ -198,7 +207,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	qce->dev = dev;
 	platform_set_drvdata(pdev, qce);
 
-	qce->base = devm_platform_ioremap_resource(pdev, 0);
+	qce->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(qce->base))
 		return PTR_ERR(qce->base);
 
@@ -244,7 +253,19 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	qce->async_req_enqueue = qce_async_request_enqueue;
 	qce->async_req_done = qce_async_request_done;
 
-	return devm_qce_register_algs(qce);
+	ret = devm_qce_register_algs(qce);
+	if (ret)
+		return ret;
+
+	qce->dma_size = resource_size(res);
+	qce->base_dma = dma_map_resource(dev, res->start, qce->dma_size,
+					 DMA_BIDIRECTIONAL, 0);
+	qce->base_phys = res->start;
+	ret = dma_mapping_error(dev, qce->base_dma);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(qce->dev, qce_crypto_unmap_dma, qce);
 }
 
 static const struct of_device_id qce_crypto_of_match[] = {
diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
index f092ce2d3b04a936a37805c20ac5ba78d8fdd2df..a80e12eac6c87e5321cce16c56a4bf5003474ef0 100644
--- a/drivers/crypto/qce/core.h
+++ b/drivers/crypto/qce/core.h
@@ -27,6 +27,9 @@
  * @dma: pointer to dma data
  * @burst_size: the crypto burst size
  * @pipe_pair_id: which pipe pair id the device using
+ * @base_dma: base DMA address
+ * @base_phys: base physical address
+ * @dma_size: size of memory mapped for DMA
  * @async_req_enqueue: invoked by every algorithm to enqueue a request
  * @async_req_done: invoked by every algorithm to finish its request
  */
@@ -43,6 +46,9 @@ struct qce_device {
 	struct qce_dma_data dma;
 	int burst_size;
 	unsigned int pipe_pair_id;
+	dma_addr_t base_dma;
+	phys_addr_t base_phys;
+	size_t dma_size;
 	int (*async_req_enqueue)(struct qce_device *qce,
 				 struct crypto_async_request *req);
 	void (*async_req_done)(struct qce_device *qce, int ret);

-- 
2.47.3


