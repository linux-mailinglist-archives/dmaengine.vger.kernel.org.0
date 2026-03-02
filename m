Return-Path: <dmaengine+bounces-9184-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJZPGKe4pWmDFQAAu9opvQ
	(envelope-from <dmaengine+bounces-9184-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 17:19:51 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B69851DCA35
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 17:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09CF531C269E
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 16:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E3F42882F;
	Mon,  2 Mar 2026 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bj/lDlIf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DpXv0vbS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516624279E9
	for <dmaengine@vger.kernel.org>; Mon,  2 Mar 2026 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772467078; cv=none; b=BZN0otdf+4fOcfpeyVdRpGY80Sv4B8x73MmLEWXGaccnofl5swSSfMyNKdnrdjIoH4OIr7Yi0AT2l9vqCBM9yacA1lOh+i/tx8T5TeVWDYs8gjvRu7/aAmvjNnQYsW6Fjxr3sJVotH7a46lb1hqBoF2o9aQ7oe5dQAXXqwfo2Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772467078; c=relaxed/simple;
	bh=ZjTo93puqxgLaTUXkUuT1EliesGs2ukWThDJ46ZWj64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Io1/CvdtqA84oqnGkZP9g54tyr4cqZ9vfRD+RbrlgqZssAiQpyNUo17OCrgJpRmAX3TEjMf6g5+Oao91ICBLTtTDvX0AtyOx9Mw1Prb/BBg3c05i16q/3K4i9NgnNxE8bXBWlbHN3rN6McxsnuBHhP5zAqkMn7bQl8qaMhJXLWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bj/lDlIf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DpXv0vbS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622Elp3u2048854
	for <dmaengine@vger.kernel.org>; Mon, 2 Mar 2026 15:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FqTHsx1l1/9oEj5e3q2mep/esitBtih9Ht1cGIH4yFE=; b=bj/lDlIfTCoGy+il
	wTHLVJDnEZjglMVroeRiu4IlDmfvZlBnEN6tV/FFHa9mvQfi4tftG2kZdFw4odOB
	QHgC/A2Vc754f5mItYFovLT4Qoy+82ZYq1zKVuoN9dZvVl3LxaBT6Ope4N2uTDWI
	S964HuUTfamMVKabBkPMJmdm8Izb1Vbww7Gbwg3BNVjP6vSGiIXbbb16EDuINInW
	+7DmTHUjq5ghEUTOwi4NiGZyOj7/6iZanBXbOlhPoMxGIFrnZPt5IQ/4tOUxu9i1
	RXsdzkl66aG3uihpAdqqoHzXYB0KCjwCnMWFLWiR7QiDNJxergdycS2xSerGAttz
	YES+/Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cncmfrajs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 02 Mar 2026 15:57:55 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb3d11b913so3479453985a.1
        for <dmaengine@vger.kernel.org>; Mon, 02 Mar 2026 07:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772467075; x=1773071875; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FqTHsx1l1/9oEj5e3q2mep/esitBtih9Ht1cGIH4yFE=;
        b=DpXv0vbSG8JOeJcMtDeom5CHCYTB3lOn04GYqGrp4Y4cjajbgAkfumNkAsCX02DUrE
         JOigFyUNY3RfMMUWQc53Xq4n1ihxucDC44XfQtFkRjdtJNugkc6q/+UYdZboMnblAtnY
         A6LWue6Juw1uTraWR/bid6hX/d+Ggv+yeWmqh9KDo4kNBT1AR4yNjGhqbzyDV/NtILn5
         D39oUb0xrRW2o0Hdj8BYmu482pjymfSwfjssYC76Z6O06lZ2XCRlBaaqiV1AdcaA4Gih
         jCaJDEfpXrDqnR47GxTydnyTWHU6ahI9uCUL7i7rmKe5wHcWwXf50xnym8tHuMDvT2eO
         2aOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772467075; x=1773071875;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FqTHsx1l1/9oEj5e3q2mep/esitBtih9Ht1cGIH4yFE=;
        b=cRZpKQeCRfxufAT/u+JFPdL/9PooXBPwG58YVYl2HcACF3Zt0Zbg3neMnO3sr5U25V
         xJ7VlIHtQjSDY71pV/Jf7/j60CSjR3cmv8M+oqBeKco7Rfbh/IMbnHnZOi8xzdkv6Nnu
         IyDpDafLs6mfrAfTjaLH8b9J1T7ZBgaHSk3FITNJ/7nraBp5Gdelifbxvusv80aSRloE
         EsxyLOJ9pIB96DVjfrwzaR9bb/XRwN8ydkTJ2S29BHcO2JTeh83n/msH3Jcy/EB8FTNo
         KNs/cxkW2RP1BB/JEC9A5vRBxafWtu2fB/OZnrLpY/kbTWO0WF+tRftVACR4We2+VzWs
         KOKA==
X-Gm-Message-State: AOJu0YyyVFLoEKeDlCCoQgifLWrcT8vqMEOviNvvMMfqBY+IThnvO1nE
	+08a43gV1LIo970SMi5GKAd5pKGqc1GH5kdFnu4jD7ybQ93qBkp4GkR91P6WEA88jexM22QEvRM
	19bvZXzbuYuNSdWkE3wa99hBn/iGF4DhynaXmYAQH1fgITFY1bbGsjxUfT0nqcMs=
X-Gm-Gg: ATEYQzxTNpMuZxazhMqPS6SWFTaSWFIzdHkjgSxmFvjN0TBZY9cK7m9m0g1nYdGm73e
	cjX2Kgk/a9YKiWxb17C8CYMId5eQFj5PVYdBqWV8CS9+gKq4sjnT1MOKIk7+1Vo2sNsJui6CyYk
	/m1zBy/QleAwcAnGb+fRALsp19UvyEtLChKldqjIypbfidoVLzeyRYoYvQ1yhnuqpEwNaszzVW1
	W1a8Qm40TUi5ZemOtd8+ad45Xus2c1HV+i1CZqZYRC40QaCvwvf44FCq7/NIld8wuqUPP1e2k5W
	FQhDW97zxZ/VpEgIHSe//QaiAqSxasHUgNWu3OfHhNgweKtPkH2A4/VOPhG1Kw6pID9DZrSf9DX
	jjDRNIL0zLyW1A+oTIIoVS2Gwt4/34YXRTJ69aIGl8ouK3nzbR+m1
X-Received: by 2002:a05:620a:4543:b0:8ca:3d7c:e74a with SMTP id af79cd13be357-8cbc8e6996amr1438251885a.56.1772467074760;
        Mon, 02 Mar 2026 07:57:54 -0800 (PST)
X-Received: by 2002:a05:620a:4543:b0:8ca:3d7c:e74a with SMTP id af79cd13be357-8cbc8e6996amr1438246985a.56.1772467074240;
        Mon, 02 Mar 2026 07:57:54 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:87af:7e67:1864:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b41831easm11282438f8f.12.2026.03.02.07.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:57:53 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 02 Mar 2026 16:57:22 +0100
Subject: [PATCH RFC v11 09/12] dmaengine: qcom: bam_dma: convert tasklet to
 a BH workqueue
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-qcom-qce-cmd-descr-v11-9-4bf1f5db4802@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4367;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ZjTo93puqxgLaTUXkUuT1EliesGs2ukWThDJ46ZWj64=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBppbNsLhK1j9d23E6BouMmy1Syjsq/SkCH3Y7D9
 L29Yuvs3B6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaaWzbAAKCRAFnS7L/zaE
 wxc6D/9IklHZUQkEAv7VtBKbEDjVJALH+W3s5NCnKWr7mjlYx01tUTylRIQydShsUtgX8iDbSnw
 KBKkdLu53Ey9b/5TcmdohP/R/QA94LyqnxChaXGpK2iIhKsNSfBBVxZnYCTR6/eYxSYkOpe7W+W
 4/g2fYUqgt5LHy95b92BzCuQLOPmvJtkscBVBnm8xDVo6mIR8dbnVib9rWjUXJdPO58iU76aFiW
 VQG228PnWm/7IKpeEwOWBo7mqjNBloGnQbslE8guY0vZgQZOI1GxRu7i+B/4fJ5ujSBqBZzy4OH
 oYeSzBxqP4GtJBCUUwHN5/TTdVwl+tJdskbauS604LrGvUKTR7Iv6VeAh3TPHL10eZ0zDXcVeII
 v0l6ypHc7kE6N6jXoDHPGmdGKF5uEDf+40WB8pxg++ZizdL1c5Ui8+M6im0m1+wRnbahiGl+MbS
 h/eXoYqfNa7pGBUUpP5I7zYEMJaP2h8u9Qtleyyx3m1ihJHGqQNH7Qii7TTFT41EkPpKp2orrqy
 xPivIDR5fwN9Wr7ZRe25PLYwUfrViCqZJWA0eFhTKxU+gV260LvZ9wHadoNk58Oi/atD2AGTE4/
 g6Ke66o6ICLtq4ubEVDC1iHX8mgXIImhcxP7/3QEyQix0T5U4xVdIuNeNu7WWJY09fFMQje+b++
 CvOtNPLiNbuqAZQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=Br+QAIX5 c=1 sm=1 tr=0 ts=69a5b383 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=u-biHsxzOdRIXVMzAPsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 81nrI7EHnXCGZ5lLB_ejr3sZ1UNtOlih
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEzMyBTYWx0ZWRfX/TSuXuAyXi+T
 dIQjL58Z7XL5IDpNZaxgw2iOhcramaZQ7yGCISjrzEx6fSIHpOVDaPq7oQ6ltELzeK2RXUX5Ah0
 DyOhAWY5k65ioIZ2vViETyx4RHRCTLXYu+lK0IMQ5FetGQEPqGFz0w4tPPL0qKR21ml2jHgjooX
 V21f/sqHvyUmXmTtlqZZLFZ6oJWo5uwjfkqi2Itb1jleu1hKIfKan7H2tXQg4sM7VBbcvLCAYWw
 2pi+rqyQgG8xjpj9YwoOp4sgRm4+8akKXRur5mCVeUChcW9Ih4rpDdoi1BNUlRkI91vXehPoAvK
 pDOcqvrVbgG0V9qUC62h4zX5KhFkOe9e7IjJwVJY3nI0ezHyvzHvrRlZskh9P571soxoVg49rH/
 EtH/S7Xt0eMGcxkbrzRBAfceAui51c6CJKDstmh704tlWL9E329eio1yAyJ+xUqWl18JbYTnaWD
 YUO914IQw2FgcWIe/lQ==
X-Proofpoint-GUID: 81nrI7EHnXCGZ5lLB_ejr3sZ1UNtOlih
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603020133
X-Rspamd-Queue-Id: B69851DCA35
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
	TAGGED_FROM(0.00)[bounces-9184-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linaro.org:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
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

BH workqueues are a modern mechanism, aiming to replace legacy tasklets.
Let's convert the BAM DMA driver to using the high-priority variant of
the BH workqueue.

[Vinod: suggested using the BG workqueue instead of the regular one
running in process context]

Suggested-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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


