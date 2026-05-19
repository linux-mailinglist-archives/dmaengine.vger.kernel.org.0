Return-Path: <dmaengine+bounces-10544-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QI2NHb5jDGpXggUAu9opvQ
	(envelope-from <dmaengine+bounces-10544-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:21:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B37D57F7FF
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69DF2305600F
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 13:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D311D340408;
	Tue, 19 May 2026 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q1bo/mAo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hSA0ajR+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35123ED3D3
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779196711; cv=none; b=LEFW8R9yOqXbW48kXQhEtn7+635PnayeUATzjRSIgK5EOj0qKNZ+cljiepo9p2wmdswtpTqbnlReeyc2tmMBH9I+x/Ehsw6THXJ48W+VcqLvmz0yGA2RM9wZOTOmdQkZSi5V7B/h5Fr/m0ZXWS4oaKyihzFBGXiPKwBcgFlhyrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779196711; c=relaxed/simple;
	bh=51qllpaj+ejQVsDQ4eqpW9Xup6eGEgdlD/8rDBDvfEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a296XqUDw97KHotEO1opOTRNu4wocHrHbxE9AA8kZZzUL0A556KHyv9Ty2Rwnj7F1Rtk7TAq8iN+/xWETVRo5eAswM52+9rCmUaxCTpx/2SjnItQZNjP1iRi94zYS0IVppf53ElgK1P+WL6MgfFT1rjtf5Dhtbvo+xQ1Bm4L/J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q1bo/mAo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hSA0ajR+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J7UOCe1147627
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q6yvC1N0mVZtsuZtG+L0tsQS32fNOMK+fMHNLzdHkLY=; b=Q1bo/mAo0V1OTNRZ
	wkhuCwIGnnofizJZJrpioab4iHSHE7Eh0n/q8lVgC8wcKvRNINzWiCDHDFkwQI01
	ltoICN1G4mozEHDwZqjAWBvVd0Z8j5u1lwWhM7dtP3IwlLGK6io9vTfeU9gXDXvi
	vqIRVD7R8I+u0HAiiZB1NJS3MdcB14o4nN4OCJY8V3AAaQypz4yLV/NgSeVEgGZY
	zWsqh83pT4utuA9R85hTe+snsOL74KLtWBNZeD7SOZIam04ZRlO8YI+o1E9aBZSt
	s33kvR2Cf23ih/QQhxHnvQ34F/k5GIKb5RYzqcIGAzL+esnLFAgrBCWHjQIJBM5M
	U7Td8Q==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8e7ejn04-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:18:27 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-57536338b89so2316325e0c.3
        for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 06:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779196707; x=1779801507; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q6yvC1N0mVZtsuZtG+L0tsQS32fNOMK+fMHNLzdHkLY=;
        b=hSA0ajR+2pG5qy3+7D1pU+Iwyc/UZJrc/MGZ7pVFfQ1v8nhwVhRuWGxPxnl5JprMX0
         dBz1W7fDdu5em5AcSmqb6QjbBMGiBStaYmCD1Inr0a8ynH2bYHlVlVGLvnwEKZXp8xMD
         Q8cjgcQSv8ZgyVddvL8YHSLnAIovvxMmxKo2zYvBtWQPl+q+swtABqWtjaMT0M8ZgRJO
         fFGtrkAzqTdGej8+fkML7M822kBrfKx3eWzJnPhTP2hETq5TCysOXYyGB7b3zNjEN8Cw
         Uzy+XagNXNo2VI6N5MDCn9EpdjL0Uqun+sqomDBB2W0HcGDFz/CN50kvUbfWEiyPpi9q
         dcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779196707; x=1779801507;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q6yvC1N0mVZtsuZtG+L0tsQS32fNOMK+fMHNLzdHkLY=;
        b=orKMRY7O162mgCTIAgVZ1efVNPqmHQuONDp4jxDtf/Vzokwl1ApE3ve0h1Jp0bQhoT
         hQhQPUlE1dcpeI6jQgCZNshACTOBZVL1Jmwr1orkxS7cTrYq/WzUk4mycvndbawvDr0C
         U012yan9vl1/PRxOCdLyVoOPTFubw6U+4hIkaImAj0tbccae1FNBSy7bhcWCGLST5rDK
         M/VHoO/OW38l9Wr3jYGcLo69HtPACfR2eEl7VsrVF1/g0zUrwd35HyhjL9RzNZORtzob
         euz8tLGi1RIiNnNKtvsJFzWwmMDxY8jreZvhUJo5TsyDYSLeqygxMbKGx8kI+ULH2RnK
         XSzg==
X-Gm-Message-State: AOJu0Yw3NGrAxZVmSvqJQwIm7lOfuAQRCuYdxdidp0u/swFZ9hcpc/rf
	wOvhk/m9cvWjUCyHaz/ENNP7evf7uq7o7IJyzmgOcvD+EdpyLHvNEZF1ulBZv0EPrKiP7P2IIpk
	GjKbyY+c+eWvN8vWKK7kwIzJF7cr9R10kwIzjB1NPJ0/cMIKwN016mBxflVJaEKQ=
X-Gm-Gg: Acq92OFaTSZeVea8Vsy9MIfk8svZ4A/UHNKaULgABFT3EJ8VmFnopxFSuvbd9hb9oBL
	Rk34ke15aBz3k9HiZo1iyJs915lgYK2D0ojDY9+Pw1G8Qv2E2I1tHG+619CK0jaFavFj0HFwvqn
	U5zHymI4H4muloXM6lbXpH03vU6AykPiGRkwlVeSYYeFUrsB+hxfufVMHKWh83FJSt2KIgd2Ue+
	LrSMlZYyDckcSUAxoPlIkBZqLI/5PFiYKA9Ct81CcpvmhTbKyOyhQiQRKDmOMWvz3yLBUqtjPnQ
	s6mDzHs3+YcOkEvoqjs81TXD97b/NPyM2d5I6zxBxQSGD0OH2bm9VOnLe/n1/69cSg/1Ef4CTsd
	lSMXjy4+wS65TFnsfYWSVijun9dd/XbCilsoIJ+SAnl2z5XbCniQ=
X-Received: by 2002:a05:6122:3412:b0:575:33d4:d100 with SMTP id 71dfb90a1353d-5760c08e3b6mr11169006e0c.13.1779196706877;
        Tue, 19 May 2026 06:18:26 -0700 (PDT)
X-Received: by 2002:a05:6122:3412:b0:575:33d4:d100 with SMTP id 71dfb90a1353d-5760c08e3b6mr11168957e0c.13.1779196706380;
        Tue, 19 May 2026 06:18:26 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:3fb6:74e3:3c25:ba2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe7dd22sm143969195e9.7.2026.05.19.06.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:18:25 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 19 May 2026 15:17:51 +0200
Subject: [PATCH v17 09/14] crypto: qce - Remove unused ignore_buf
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-qcom-qce-cmd-descr-v17-9-53a595414b79@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2066;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=n0Cml8iSZ+MTejAlSL1Cpzw3FwIEirUqeMzFyFiqzq8=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDGMKz8dbjF7OBkf/RWRj0NdmRujUn2PqTJYgP
 UoYP+NdutGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCagxjCgAKCRAFnS7L/zaE
 wyWLEACxE9gJq++Y2ztjc929ID+NRJzmKorqaatD9rnOJ59HccANwaGyRcQPvF0ibV9BoUDDWQM
 ojjbGC7X0xb50YDrt7VSKGjH1uOXZqQF2s9Mr08oG8RqVUEJo3eSPqB6mfBzxPGcuSskyYcZO3k
 t34wBDR/zLrowQ0x4Qic9MUtQ9MnpQck25lFomtF/kQS4XN0hy/3LqRclILm2tIzXqaBdPB4BnG
 Od9Ziz1vUvLZ9a0bDX5Oc9fxIMatqPNaYwB7TR3GprjBpXFcUWFPtqh8i1ul+c2Zm0sEl1VhQUs
 tL0aDHZvdjknkrDvUuzluoFJ6t2RpYDS0RrQ4qWFSa3pRcY97AuXyxNQeTs5v3HYlW8/W+Bloi6
 zE+jlrOdpNROP8WHGCebpi5xceSwFCfxkkh2nCxbQncvNlvztleUAhA+jZyh4H665uPRyBFu2RZ
 HKwvY/ma7haHOPkQzwpIL7TBz9R6xTUkeCvyNQM7h6rYS1bp+GbMaovSf7+c5xwh1FrCpyGSZXJ
 9rCxX/OEt53EH2y+2ueEXB5FNpmQFTowQxqQ/9ocadalWpyrttveEPrn0pOKK9B2807bqZUevo+
 XfsF26GiHpGDm3OxL0+qpAu01hhLwgzz70FbzH/mOmmQxQd41hgDkrYeNOaIn+W/ciPT+U/d8Ry
 C5bRx2/yDatq8dg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=Rt316imK c=1 sm=1 tr=0 ts=6a0c6323 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=KKAkSRfTAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=tWRRbWwrKX-5tUpmLDIA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Ds6fMz6_eGG0eqjhvTt-jeMDjcecnie9
X-Proofpoint-GUID: Ds6fMz6_eGG0eqjhvTt-jeMDjcecnie9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEzMSBTYWx0ZWRfX0YEYV9sY4QtA
 CZlEpRP699yQqwQ2Tlt6dGFpoBwOQ95RI3U5/mEmsaSvx2RyOOz+JrRprZE8L9+p6Vo5mSq2fnt
 MEL/fbrEGZZNuiADar29ipfByCtLoSwHKCsGLtbS/BONq4c+Ymvxnf0bezYWpTGag4KyPTf8GIn
 QtXSRtn1PM8Kb00QIQ0TVfw381hEbMuFdkX4tOnHrjJ8Yli1ARvNBVzRhdkk2jAbmqEbucuEeDM
 BxOvUbk7e0Z4cA2ockGKMKZbmZh1yaseNojCL/v1iP4pTMYi82ouWPReCXVoKbNZG2DUPEyC6/d
 wEtFKTGonaJ9sMy7AgebGGrvAMJMmH0Tuc109KiRbGSSRWI9ZRn2VAzHAVQoM1fVFNzTD/3Rub6
 O0pjsNCzbBxaaMWBmqbkAYlMxLZT0+LYy5bOE9IGJ0W3b0DLPvSvfpfdx6aUPNTGcks2wwMkj2+
 2/qYOIbLQwGCVDaTYHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190131
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10544-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Queue-Id: 1B37D57F7FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

It's unclear what the purpose of this field is. It has been here since
the initial commit but without any explanation. The driver works fine
without it. We still keep allocating more space in the result buffer, we
just don't need to store its address. While at it: move the
QCE_IGNORE_BUF_SZ definition into dma.c as it's not used outside of this
compilation unit.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/dma.c | 4 ++--
 drivers/crypto/qce/dma.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index 68cafd4741ad3d91906d39e817fc7873b028d498..08bf3e8ec12433c1a8ee17003f3487e41b7329e4 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -9,6 +9,8 @@
 
 #include "dma.h"
 
+#define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
+
 static void qce_dma_release(void *data)
 {
 	struct qce_dma_data *dma = data;
@@ -41,8 +43,6 @@ int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma)
 		goto error_nomem;
 	}
 
-	dma->ignore_buf = dma->result_buf + QCE_RESULT_BUF_SZ;
-
 	return devm_add_action_or_reset(dev, qce_dma_release, dma);
 
 error_nomem:
diff --git a/drivers/crypto/qce/dma.h b/drivers/crypto/qce/dma.h
index 31629185000e12242fa07c2cc08b95fcbd5d4b8c..fc337c435cd14917bdfb99febcf9119275afdeba 100644
--- a/drivers/crypto/qce/dma.h
+++ b/drivers/crypto/qce/dma.h
@@ -23,7 +23,6 @@ struct qce_result_dump {
 	u32 status2;
 };
 
-#define QCE_IGNORE_BUF_SZ	(2 * QCE_BAM_BURST_SIZE)
 #define QCE_RESULT_BUF_SZ	\
 		ALIGN(sizeof(struct qce_result_dump), QCE_BAM_BURST_SIZE)
 
@@ -31,7 +30,6 @@ struct qce_dma_data {
 	struct dma_chan *txchan;
 	struct dma_chan *rxchan;
 	struct qce_result_dump *result_buf;
-	void *ignore_buf;
 };
 
 int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma);

-- 
2.47.3


