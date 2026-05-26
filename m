Return-Path: <dmaengine+bounces-10948-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aB/1KI6fFWr9WgcAu9opvQ
	(envelope-from <dmaengine+bounces-10948-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 15:26:38 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AF05D66F6
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 15:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87E9D339FFB5
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 13:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EC33FE350;
	Tue, 26 May 2026 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fYvR5w6s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OgIzIFnn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293BD3DEACA
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 13:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801100; cv=none; b=u9L8lSDJKlQauyh7VjbHsnSSD6oOpltpvDXLfds8znf637bImxTDceKqvjSRBWiCnV/d0rpmQ3S+cxzYhkEEEEYleNUk4jp68VLdNRnnRyaKLHEZ61AQlSKfB643etyakJFzYpOX5rimHnXZJkwWNdI6CEPlG4z04GNoGAbGa/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801100; c=relaxed/simple;
	bh=vpDVf/b6zHPEUgtVCAl2sRJELM4MLJc6gtP24/up104=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b2p5SQEaBG3M9WqJ1BrqnwycVK0QWW20JSCXokP2Q1XlQfbWbURqq0Hdo+sOl+gVDOJeZr+Za4S70jgB7pb3GFcj28mFU3+/KMqWRBRTQpUz/Ol0xdo/SvNyTudyl0cmciuGh4KPLTviuAMKECKGV6EPNeTuKpzRAzS9tIdrof8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fYvR5w6s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OgIzIFnn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QCsiTw3797182
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 13:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	twry+rQD67k4KXlgASz4DIRuOCwVvltNp8BQTuA56nA=; b=fYvR5w6sNi7BMsr4
	dpFPfDr5EHSwZvnJfvxEn5F9C+GU349KiW3BLfyFmYF+EgWiyS4k8/fcYX9ZpV6z
	5TdFUz3zXnCYsljKexRxbQP9Z1DBniywQ59E0oIkk8G9DwY4OBv6hr1lNV9L2BeC
	I1OdZOZE7K3+IcZYI/p/vkEZks6uqjdDVwp5O2lVsEkYASAwsIrD4e1Zo7W104G5
	RjCf1fDa/Ff5ygjsMZqs+wxGjfPA8sKHChl65NFHNhETokdczeUxxwbWfr86aqw9
	IRTyoDQlB1fimEPOO4sOOm8Kt8s7zuk1AbAk1wiS1fizWYpqePQ75Hqb7uDXmX/A
	Hu0AiA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecpy2mg9u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 13:11:38 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-636fce7dc8dso5503699137.2
        for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 06:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779801097; x=1780405897; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=twry+rQD67k4KXlgASz4DIRuOCwVvltNp8BQTuA56nA=;
        b=OgIzIFnnymHMAL4iRFkPX81t3cO5wD8p7Rwi38DkrPvZPPuBINzAQc13ub2kGwB2Tr
         oEUTmiLm2VoIketq4kOo4aPX/UChgE0VLIhDVplC6I5f52ByJISjZ8aKntRCrelmRX5R
         BVrWhRsDraXu5T3TIZPM0GpLNS1SIXDtF2XeLJ4Lx+Wt4imZsNev35C+2aeJRzL2h3v6
         /U/tfzondcEdqHgWazr8T40MTQBmftptOolldDKZwgnVtAtN3n3WxFoUW/VGmJU9p6bB
         W3hfle9auj20uIFZF8WjsQi8KxxXTz+jRb8HfHus7ddPv5jHioQVdVUH5BRJz/4bqItk
         IbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779801097; x=1780405897;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=twry+rQD67k4KXlgASz4DIRuOCwVvltNp8BQTuA56nA=;
        b=E8j7nwvhBDmQPqtC05Oog0aAMpX3aVGk0+Pi2zAYmFhyb5qx9Nqee0VlJQHgYRXbCT
         pvKhic8NpW0YaA+P5jvIHnS9bDk1GedaSnJVa2abhBjBEtR+i2UAZp9vw9mjK6WCIbSF
         YXKMDyTuRTUiAvcc8J080zikuFPQNWJAiWmESbZLGoYtkNMPW9/bXdYg0qgxQegZ1gNW
         N10bSIpFwrOBV+OYf1tPOUPVDBtBL08rGysG2Z+K8eIsa+zG7cp/aJtL+QHcuiAxZbEH
         HlZe4bq3L+c/oq/ct8N8mOaUU3JfTK7Opy1ak9UXJeXZFH03ddljdEpsamvxT1KGgyJr
         EHqg==
X-Gm-Message-State: AOJu0Yw2efrGcX6S6LArZDNc4PjXHXtAHRJdXAOXrepuIMOTAux2F9YD
	CoEvGncYuJeV4fAQnOybP0AErZ3C0na6YB2ajzbHShFUuP47cBZV5THhDdKZzU0KWxG53DZmDCV
	Ozi4TvwZnOxyZyIkrc4firn1U3vgWAS7+8VZB8rCUnCQEpmOgPm6K4Lr+7a5za70=
X-Gm-Gg: Acq92OG5QihmMW+4NJ5FSaqvdHO8SNngx2wHMfPqO0Y+jxpc0zQJuEGexBXA3rar+WK
	V4T+xUcOHBIB4/p3UDaMYiQbxAHj9hwXscZtbZYKnE+WyaV21P7ujoWI2wYZufM8WnUsGGokDgo
	gdgqlwdK09wnVCODcoJL3ynP1BJhhGyCz7WAPC1oJLc61wDCO7hQz9bHA+G4ujZ7NhxGgTL7cYl
	XnOxdd95wKEicekkYY8qkrVyshFFholhWNKLZgYcPf1hFBywzfzozJ0r56sg6ZiqFPDBa8zjxNw
	siUqwtS3tYk4l1lY8Ma+iQxsGBxKvCrEVyyMle5DYpC85DWliGmBBMV2UCDG/1Sl3M8raBk8aO8
	p6Fii+N/Z37QIb4ilZE7T8baAn7EhXvuqHl2V+s1sefSdK+Fj8FckUvbucFdc/w==
X-Received: by 2002:a05:6102:689c:b0:604:f849:462e with SMTP id ada2fe7eead31-67c8e97905emr7864560137.25.1779801097231;
        Tue, 26 May 2026 06:11:37 -0700 (PDT)
X-Received: by 2002:a05:6102:689c:b0:604:f849:462e with SMTP id ada2fe7eead31-67c8e97905emr7864502137.25.1779801096708;
        Tue, 26 May 2026 06:11:36 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:15ba:1d70:65ea:9578])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5e484sm34259426f8f.30.2026.05.26.06.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 06:11:36 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 26 May 2026 15:10:57 +0200
Subject: [PATCH v19 09/14] crypto: qce - Remove unused ignore_buf
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-qcom-qce-cmd-descr-v19-9-08472fdcbf4a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2066;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=j6XY4tGbVrzzivRLNBnBuYRESnCKLFI7yXVP5haQkuk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqFZvwqOknm+Sglsg/uIVkQOWaSxMSKumM4PoIj
 kftpwf8nOCJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCahWb8AAKCRAFnS7L/zaE
 w+rsD/wJMly2un6WFFVD7UJ03Bc4ShEGXIFwEcQVsq8e+Xa7FxB/JpHyDdV57iGPjfpiet5Biww
 PoyWytdBUim6dh3Q7BTADj+AeO7mxw2u3xdpwPi3/x/gcNGRH26OV5Av3goFZyhkLpUDT62QNt9
 pyYMcgAIFaBgEmQKfcq+dP3pnRTvvMyjf1UMUmjKEGIJJvDeBIeMrYm/1xXH5us6dvRHLngjA0n
 PLCt4dkaneQmWnuGokrHx4VKB0z1LnGGA+gaPOsUBvwAfJ6ZndBGqRlLKxvX5okM3K7arY9JMR6
 EMMOa8UZuWPxL9+M+WCiIDTCR1nlLPqS7Pjvz9Oh2VtyYSwhkYR3Ob0iWMZ1KraJEyIfHuo7N8b
 jnj87TtWJnR8zMaIsbvd2J19LFpYxsfnZPUD8h3+HR5rVlUvJrrDm903yjww4sQ9DvunUC4y5Hs
 Bbg5poL45iBcgYL20dfor6M4vYLhijGJxZ/Cfa4YcEMzSYKF5eZCbnsqtY0yS7imTVafpaDf4lm
 KAw+aHaCr4YHgEJ/mX5CfhQSfq5QghGd4c2Ls7VMKtVxftyzf/0swzaxQrJ1tlcwLnIK5K2Qm3k
 HhH0Ra9K9QHzFSEF/ZdR+3UyRQrIUvabSJVYRRdx1g4+EojjgN8k7SCunAqJBqcbEi06btoKGy2
 2ojBZqk7hAD1/eQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: dpM1heRzWy9fr_juE-xBLLnFnIlEX7Cv
X-Authority-Analysis: v=2.4 cv=ML5QXsZl c=1 sm=1 tr=0 ts=6a159c0a cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=KKAkSRfTAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=tWRRbWwrKX-5tUpmLDIA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: dpM1heRzWy9fr_juE-xBLLnFnIlEX7Cv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDExNCBTYWx0ZWRfX4DABNzJfquGR
 ko58UuNeCeepExvNaFG1yTBbMJB1rlluTeEPAm2Do0QhWdRxV7BILW4FpPjYfK6n+cCHMW7zFiX
 cYEH5+6j16AMp+l5ueB4Kamyg8W0Be8BBVrRnghXZWhdn0j+8hpjdpJ9+NCPPXhtyqks4xwyKZD
 z3Hw7zZoH2+BN9GpXyEIeGMI8wrx4c2alGj06ERZ15+gttJNe5rZUjV+ILqpjTLaC15GX/J4+3Y
 WfYkvnF1Yx0XmglEIHXvPP6qwnQnFXDy5du1VAXkYONRRMqYPkUXUv9gVRiyRBmwM5WQKh5w/EL
 rWpBrZCSf2FMtyczJQfTJUmhNR4iUjLGWW9/HVAP346YgvCKzNsoKaQcIrN7kyAcbbrdLgRcC3c
 3v8AjEWE5PbxoH1uIQcregyzrA4IkPx+SVgXfxafbQvWLhdYaFOVLMUPJj5wHKHEWMjeMPJ1mM8
 M+qmDTkp1YqHv74++XQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260114
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10948-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
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
X-Rspamd-Queue-Id: 35AF05D66F6
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
index 7ec9d72fd690fb17e03ade7efe3cc522fb47e1ac..d1daa229361aa74da5d3d7bfe1bc8ab189761e38 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -9,6 +9,8 @@
 
 #include "dma.h"
 
+#define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
+
 static void qce_dma_release(void *data)
 {
 	struct qce_dma_data *dma = data;
@@ -43,8 +45,6 @@ int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma)
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


