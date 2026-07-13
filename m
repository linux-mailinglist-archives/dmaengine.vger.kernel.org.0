Return-Path: <dmaengine+bounces-12381-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cuyjA8ziVGrSgQAAu9opvQ
	(envelope-from <dmaengine+bounces-12381-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:06:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9533F74B455
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:06:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Dr8id1fb;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=b056k211;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12381-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12381-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C681630519A5
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 13:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE49411682;
	Mon, 13 Jul 2026 13:01:47 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DB9416D16
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:01:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947707; cv=none; b=m0DGViJH3tWItB4CwLGqjFlJZnoy/OzIpPGFgW5IGzTS2igyLz1aaTbQRFoh9Q52fP+GqT+QTLSNwXFZYYV/bDFSs7Rhrr2Qhfz8DhDNbdxxD/AM83ysz8NiEsrLsAnOuCBSnQXKawg/K/Hq0rt12QLF5KMdbF1uJlElSsVzQbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947707; c=relaxed/simple;
	bh=zHIuoWgA0JNzB45qmsTvX1DiRfFAkkbG2L0hbAcWpaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PB3qfc0XP9KJfdjgpMjHa27ykW/WQst87jrI/mfnmIKsf4hvL2IBg1P7s26/ZOX1evVrTvQO0bpvhzuffrs6nqYhheaNilSeFS3lQBawJ+EVMPC4vhPQy949hYda9jwGS+xAH/5dTi2GHQNlRaRdjs+ePbbZ73oBxCpbtj9pq0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dr8id1fb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b056k211; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCE4Rn1494918
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d0wSBB0zdvgp8nv5/qOGe9s7Ri2Cp1uCk4+HjNdiilI=; b=Dr8id1fbqQe0mNys
	bDRxf66KIWEKPjeeJ8XwNjYo/t3irvtChuVaq0aNn/TsugRGyygYjTsdye7NCGZI
	bMaFovRNSLO9jG8rzE6+I0oYU0IbsKamMwKBWXfeb/hYK9OeXhaxJv6+EHCLi8u6
	kxSZZ314+LXRlHtAng+nbCRofqcehn78SgHJoI7FJ9qpuAReKcnJ/jUyhAi2vz+g
	qWjE1qysPOhmjWDwtO+MGkR/F2tCGQbwVabZTcTnV72qOfYcOK5EQi3xOEa1dnL/
	fuV70a/DSTdkpv91VrS2joaMOzdxdh4+QF1QIbAwobQ0nn+Uvdv0Lm+QGdpgjULq
	Lb9uLA==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcjnm2mjm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:01:43 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e9fa2cd5c9so4547379a34.2
        for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 06:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783947703; x=1784552503; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d0wSBB0zdvgp8nv5/qOGe9s7Ri2Cp1uCk4+HjNdiilI=;
        b=b056k211bJDh/sprTk4KzyX1vt01GTYx+lXH0Hkx0uqOeTAfcTeznYE4ajbPliA9SZ
         Dd6AOprMvVHbwZLlye4w2Jhmt74E4Qi5jnX0u482dP2dzHYxcxWj0oD7BKrMk3kJ2hMP
         UVGjQzlnMAok4SGoQHsSE5UxYD6aXW+8+rriwABNSgB6izACLUNQzjs48C+mvWqjsGlo
         Dl0ip8/TGu3ki4w0kJAPAx/m8kNytD3z+IW91g/PKv/ywm4qa7/aiqrBFOfM+UJkt9G8
         vQGVhXB6c5T2dawE4/rtpgbLdvS05qjpPaWKg0OyWeeOfn2RXxChangFgp03s0u2lLJd
         mq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783947703; x=1784552503;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d0wSBB0zdvgp8nv5/qOGe9s7Ri2Cp1uCk4+HjNdiilI=;
        b=hmiTXi3uwmK0/wbQoKN9AcFvU5AtINRnBqN4V+9YWzfFLFzukr00YyJXAO/zrX/1bD
         l569Aq02APVlzXcsBBpUcNSmtx/Dn/l6sEuYEmoj9gDTBKErhUH1Cfamzdl4WNuXRppm
         y5c3GcZ/S8rjERXtAxFxDozkWa/J3ADonqDQfqfaSl7CPxdslZ7K9FCUO1pHa5ElSFSf
         qFu8x7TU1pAJEmX/c73JODuXWqpptCs442CO0RA5nvkqKc1uyq2knuuFXZ3nY8bt7pf9
         4LyyDMQ3JZO88/7skaz4KY47Orbq7T4cCdloLKlT4rFcHjJ1mKqIzFJZ8gmnGaz4FVUn
         Rcug==
X-Gm-Message-State: AOJu0YwNXBIxFu1bdlEY2H223HEEltJuN9BNn863QMPJbpXYG5JTsFjb
	LbrZIC0Z2zfqLyaT9ri0uzlMt17DAUWdkYaTHqrdGkhDttMv2fyGVKUffDpGhBPzOFwsi3mV8+t
	ThR3tVxP0RljdPORfPp6OEvhJvlOQTdmx0GsRDX7RudkJ/Eu37yNnEua4vMP3oUY=
X-Gm-Gg: AfdE7cn8Xo5IwpS7gGSIByQ1H4HP4LIzZjpDV+dFBSS9jIMLr6ccYMW4ja5nn7ah6Wk
	wEIutKa9j9sNt1+5giNs2FH+1mZK2c6K6/w1o/b0Uo72Byfu82s8h3UHiLHI46mAUp8uiOMoE2H
	iGBgpHNK501O/QBjaIOoSYnx/CTCIn/1rEKzwiytA4o3Hd9HmNAvcbHNKZXsWJRaLrnZ7uk0j4e
	6MwurOw7ZIRYEhd30E8YumNy61SOx8FDyXr2zQRuDSXHX1mW5y7opv+un87TdxjPYbqjTA0UFZz
	aQu5HzCkkVrkjZcHdE1Ikdm24N1q7XKQn3sLULpuTKXQZPXonSkxCKvqxtnrV0+NI06YZn1d08X
	fr/QpoxoCeBtdRtDlQrUb/t+aX8/0k4HX6F7Xe4Ro
X-Received: by 2002:a4a:ee84:0:b0:6a3:80b9:d7aa with SMTP id 006d021491bc7-6a39a6cd4d3mr5189807eaf.34.1783947703033;
        Mon, 13 Jul 2026 06:01:43 -0700 (PDT)
X-Received: by 2002:a4a:ee84:0:b0:6a3:80b9:d7aa with SMTP id 006d021491bc7-6a39a6cd4d3mr5189750eaf.34.1783947702509;
        Mon, 13 Jul 2026 06:01:42 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8881:83b8:89fa:1a2a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2d97527sm306129725e9.2.2026.07.13.06.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:01:40 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:01:06 +0200
Subject: [PATCH v21 05/14] dmaengine: qcom: bam_dma: Add
 pipe_lock_supported flag support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-qcom-qce-cmd-descr-v21-5-bc2583e18475@oss.qualcomm.com>
References: <20260713-qcom-qce-cmd-descr-v21-0-bc2583e18475@oss.qualcomm.com>
In-Reply-To: <20260713-qcom-qce-cmd-descr-v21-0-bc2583e18475@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1807;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=8sCOVL39BX2AFiqeGpscXeG1puX7rtAOjEFEhJGJOUQ=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqVOGaPsc0Fa7oCOUveANJ60kMxtnneAWu+40XI
 sHiKYzzr1CJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCalThmgAKCRAFnS7L/zaE
 wzQ+D/4y8gxcLmowoTwpYu6/hbyBFcOrtC7x5BDbiLFBPjw8I/IW0TFnJ+GNhGJQX0rglPvFUGk
 E7Dt1oHIW+5lFWTJc5kgUdyCRZHTLY4Li23JVCxFj/cf1a1VF6fJC9rWpod3vmr3j0+pF+OFNMn
 boxzJHPB/pcJF+YiFEb2ZKmOG8LSPKhXnjWUTSyJI+D90cfyqLC8T8hTzIaNs7GUmeivuZaEIp8
 ykxseEOkwZ5iV3LDhkInSNXDwoegrdxf8bBiJLMw2aasSx/8DZeVmulN+6EP2bQxmvwKMzIlaVV
 tbFGw8MmR6KCFFROM9Ew7a+aBNcDVklXTs4bwKjMtZuBO4fl96oTLWi685Kdpf4CTuRZMECeU9I
 RQxMk4Tn1+j7gtHSq2QkLcNUPHnSblikm/wl4n2QNgmREo/nTzIFDuiS/7qObgC8SdGmjNIpol4
 DZ6m+yx/THlh/c0RMsfBev3a6ipc0zOXf0MDkqig/XW7SwFIickz0gL2foQAgrrv6bwIZLuI7iu
 p/cwEC0JBQN5OwY6R9R5KlY+Zv2esWxK0LI6V4Q8dm5APmI0vSAaidEczpSkeNQWzhWGDAYOtUp
 CO/n+FNteqnrNMOz+WTd0A3Hvvlkffb6siLl/Zl/hbBDnMRnNBDjRDTQMjUHsXXpwbZX+eHrORQ
 hP8dkSZdbgPBmBw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: U2tjeMQZOtOaom6IMBI6pbDs4RYWdQQV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEzNSBTYWx0ZWRfX58NkjH4WV3dK
 v5dfxnJ+9EPyP+lHQvac8/5nJEyjoII+JS3Sh/rtF4fyTCe2RwMbww4YEXb5tks+PjxhgXyibim
 afqNb6bFNfTKKty0phMgGeKNhMY/Cd5+1P/oJTVp33eQvNDNXn9aeyC8OCAyQZSwub7ns5rbOoc
 vLTcaLJuvG0ZarvAwmm9NRc28lnHvaeXzq+DIBd6dTjP96+WxyZC/p/viAEnWgjVi8j2OLRPHA+
 Gw3jdpRiNYnHAPPBVkp6VfS+mvq7zUTYaWU6xRgsRX8tnQGXXDFOeXemieLJ/DICzlLJ6rTmW7a
 H+X8bVR5ymSKkPrjzpqAFOI768LL8adsT52mBlVDNAnbcg43R0EGd6zVpnIJztrdTyafLzYb8fT
 xaM7FoJr3pc0Igbka/f9ny11Q7TGnUOcheE/H9AEUEq9ILPsJ0rzRKL4pMB2D2PZYpKuEtgxZbZ
 oXl/eSXeZ/DqGsdvM1Q==
X-Proofpoint-GUID: U2tjeMQZOtOaom6IMBI6pbDs4RYWdQQV
X-Authority-Analysis: v=2.4 cv=AfmB2XXG c=1 sm=1 tr=0 ts=6a54e1b8 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=ZSnkYuKn9ZpO9KHknGoA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEzNSBTYWx0ZWRfX+aCapopVv4DZ
 nkrFqZHz8jsL8Xlt21lgW9erjF3VtfQLgJLulnRUc3IsUi9BXJz9I2NPFDYHO2eTqQ4P/sUpKgm
 UAr3OKUAN/hbb1jnAw1BlrORtIEtqVA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130135
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12381-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:corbet@lwn.net,m:thara.gopinath@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:quic_utiwari@quicinc.com,m:mdalam@qti.qualcomm.com,m:lumag@kernel.org,m:mani@kernel.org,m:stephan.gerhold@linaro.org,m:andersson@kernel.org,m:peter.ujfalusi@gmail.com,m:michal.simek@amd.com,m:Frank.Li@kernel.org,m:agross@codeaurora.org,m:neil.armstrong@linaro.org,m:dmaengine@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:brgl@kernel.org,m:bartosz.golaszewski@linaro.org,m:bartosz.golaszewski@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:tharagopinath@gmail.com,m:peterujfalusi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,linaro.org:email,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9533F74B455

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
 drivers/dma/qcom/bam_dma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 8ce0fe085c5fea6cc614edd692b5cfd264b94d5a..f3e713a5259c2c7c24cfdcec094814eb1202971a 100644
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
 
 static const struct reg_offset_data bam_v2_0_reg_info[] = {
@@ -247,6 +250,7 @@ static const struct reg_offset_data bam_v2_0_reg_info[] = {
 
 static const struct bam_device_data bam_v2_0_data = {
 	.reg_info = bam_v2_0_reg_info,
+	.pipe_lock_supported = true,
 };
 
 /* BAM CTRL */

-- 
2.47.3


