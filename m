Return-Path: <dmaengine+bounces-12385-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WArSCjjjVGoNggAAu9opvQ
	(envelope-from <dmaengine+bounces-12385-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:08:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8047074B4F4
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:08:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=mtKQ6aQh;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=dVZFNWdF;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12385-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12385-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7AA66306A513
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 13:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536C14218A1;
	Mon, 13 Jul 2026 13:01:59 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D97416D01
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:01:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947719; cv=none; b=aUe9XsMTm4LnyJKBXsK3GaJnV5spKG3tD1sbCM3cEGcYX0sg4Ns/UqmXp4EdGJwJXKsM0g0GrPgl30UMd8hW2s662YFHnZh9M2zLrG7D3OZLgNvrWEfWlsyNCGa2WC1EM3vLIxLm4AozNIGTKWxHpax5FEtKdDbA9Jy7ex6mAe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947719; c=relaxed/simple;
	bh=vpDVf/b6zHPEUgtVCAl2sRJELM4MLJc6gtP24/up104=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bxvo42KydDNgzu3xDuL2ShxThK0cfYr5bM0o+SqSN+CMz4yJtVidZU1VEP50XXJ1RcWXAVOJ5VEJyuF6GiALSA86EBkd1cKZssLR791v4SwkNCF8O6rgyzBWVquM7OSdzOrv7adf/9N861mKoZQpXXqV8yTt4qKLFKG1Wd8CuUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mtKQ6aQh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dVZFNWdF; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCDve41494374
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	twry+rQD67k4KXlgASz4DIRuOCwVvltNp8BQTuA56nA=; b=mtKQ6aQhFyuDQE93
	vLS0PLFWn+3ssts+aKobAO4Z3qGaqUVXI5gjuS1xu91JAaK0kAk/MFI1n9gRiUXK
	VZzGPSNz7Bp8q1PLeYXrHFP1zBkaHghZt20UDZxw9SVbih6HTBrYynh9ebRMxzq4
	x7idrnW8SkVIPMMgND2OOJ9L5ZatDG6f1i0qL5BlTCGbRBX68aqkgW7qgO0zmXe1
	exmg4REXsTFM0RWl+20r6ygIGPNOxnnFnAj7bIJimxGs7typmqwCVsb4VRF8/iPS
	4TOkXNTH8GpUVAUlnxv++fl7mtAbYY+u2zDjZ7DLmFdVMOxrhx523pVll9J1dIRf
	6wTqRg==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcjnm2mkv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:01:56 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6a373cdae78so4631739eaf.0
        for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 06:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783947716; x=1784552516; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=twry+rQD67k4KXlgASz4DIRuOCwVvltNp8BQTuA56nA=;
        b=dVZFNWdF4A1JlGeWpiXaOtiTdGCUNeInmkwmovudvfh4wodJpBuar1rWVS3GVZ0b0Y
         mqoPnmUaBLfXyWPP1OPAvNKUqNypwj5Vf3AWuuYBVTx68FfW7wmURaUTjo13bjNnyrLf
         R8GWvLXcD/aZgTT3Z7X9IOAmLSgcuK+kqEXvdtMVqgk3Hbt1eQqF+plcWnsL9GM0ukcd
         hDaEbTnKzjsTRiSQq1+0A5b6QEzVlV6nxkYNFFgUQphQVsKb9EGYMzyK2GTn1NjLHX3q
         aPXq62j4x+ei3phtojSBlQv3uNpP/ZxM7alNM/CSWkINALnVH8435HLNNplaFH/UFZri
         0mxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783947716; x=1784552516;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=twry+rQD67k4KXlgASz4DIRuOCwVvltNp8BQTuA56nA=;
        b=UCPCG2FeULXFFqGMrAUmBsYqErBTzugZq6hSeO6/kttjzQlkZjCrafiGFy9WBVPR/a
         D2IJPPDPPP/potXgoDnS14quvV0RcMvjgAUber8sq8mfIgmgHHiM06mFYi2d3j8E+je8
         K/umqkWGEB1skvQT2Cpj4qnWtScEV6UCzTUFnuHYgkfY7m3RjoQg/jCh/muC+Mg1Zlvb
         aw//UOGS95J3Mx3o9ToIWQ2FvUY3scT4GZSApC120KYBJ2npaHJDXYg1j7NX/pGfatYh
         Z6tJbtlQ2BHRHPsXWDsIYDvIcGQ/aWr05/uc95f+cd0nKQhQcMm85HdSQXSD7Wh00DmQ
         VUEQ==
X-Gm-Message-State: AOJu0YyYAHKCl1f4G3l0pSQNZPGROXPTQy1HQSi7XVVX+P0yw2aWJB0n
	xZGDfozzxiLxTs7IXVwki/3gsEktiCUGOfjSyHifcUGdKBVQ4ttt6+ahW4Pzm3VgLxdz6vnlDpE
	TZJ0t1LPInFaEkZwrtj3+dVstwl5sABBCDYzspmBD0hWUTR98OTL43DFon+TX9rY=
X-Gm-Gg: AfdE7ckSEjK98lzqkzcv/enHOZ9fSyjNAEzd7pf9f8eGj7rNsmoQUqMsWoIuUMcvz4d
	aOYvyq1AQWm8Mxm/h1Q/W3+OgecMIWZGRQRAdP2wbiob93JVT2UpauLfWWlaRX1sNnnDFq7FGMV
	DD4qmOE8WR6nRdAvfeLSPSS0OFM13HbivirLtDrhFgGEVNMgMR6Bafe0EWYIgUN0Py1LtsEYjbW
	XLSYu32cpfIj47VmGLWhSxBLEeUe3KdeHoEOLdAH2ZvHn68ouXe7DwJKWK9IuSBryU1jkwD/Dt4
	IlT0yrwZpuUBzP7yYi7uSCpt03HiJQL+NxTWAaRsVTxKVebBWqrpfgXDJjSwLIcB25ky1AsT8JW
	Pe758/BAsJbU1b7NFK5vlX+L9XhCrqj4/t+RCG2ee
X-Received: by 2002:a05:6820:4cc1:b0:6a3:916a:1d26 with SMTP id 006d021491bc7-6a39a8561bemr5855907eaf.61.1783947715865;
        Mon, 13 Jul 2026 06:01:55 -0700 (PDT)
X-Received: by 2002:a05:6820:4cc1:b0:6a3:916a:1d26 with SMTP id 006d021491bc7-6a39a8561bemr5855857eaf.61.1783947715189;
        Mon, 13 Jul 2026 06:01:55 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8881:83b8:89fa:1a2a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2d97527sm306129725e9.2.2026.07.13.06.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:01:52 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:01:10 +0200
Subject: [PATCH v21 09/14] crypto: qce - Remove unused ignore_buf
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-qcom-qce-cmd-descr-v21-9-bc2583e18475@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2066;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=j6XY4tGbVrzzivRLNBnBuYRESnCKLFI7yXVP5haQkuk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqVOGeHIeb8ttU8NMHmfvZe/dnHD8TlSqP+D4CC
 DKyl2r0VFyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCalThngAKCRAFnS7L/zaE
 w3GID/9wtsZ7eG9siySdL9ECGYbUZMDbkEeFrIkn7nhWh+imlHfzg+aps1ekYXqrnnKoNpMAcYj
 s5S+a7t13UfMF0H4ezCA4SmKeySbw4Xza4+KOINoRrCvitkyhrOhRnOFTGtL5OYdsxUi8vBYxfA
 bhOYwwMqCw7xtvs39WG+W+ugZyCQMBrvMOVao1ZTs/QOVw5JdfTK7Enjn6CPI047t7+XtVbdcnR
 AO8b52ajf+00/8XS9y2hWNMhT5hPJq1QjkwjaCBTObA23ROM4Z7cGEXjrn0TNSwFOGdiBaI7voe
 FCJ9VyAiQ3yRc5198Eni4HMzXj5sqx9F5X+ZYs+sd8lJrvAld3W7gZMIZ3TJ9SZ8cpTzqmMqUqv
 pwheSNQn9xKZ2M+opu+1hy7/26q5i+Wk/hNPr8w/gYP29uPGH2/ZCBTwH3mHbK4Auw/w8oHI+aA
 q2aXjx9NPwmqdFBvo7EHkgNDmckjNdXVmbg+pmujnI8AeKsKpVqartHSq2sVSrE4NnFPbjGNlfJ
 GYyJNVtENy8vNNqtCs2rbm1CX4Cp2nNLnd4GPm257Yy/HS1E8BhMfwaVKgbqszK9Zx/smc3DJvT
 pOtMoWNgul11dbGF21pBRIe4dSyZoJ22b64Quq16v7iBe6XsVrKSjj3xPBP9JsDPEYNkrtYJ8vf
 9BPGsifSF6T4yow==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: bmkFzDFi1E67xdEzYhnqa4YUrneIUoH7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEzNSBTYWx0ZWRfX7rtjRcxMka1t
 HjN3OvG2Uwdmn4M/4oAX1THI3hKveL9Z+mo4N+oNZzSu75jPZthvIKMEx3j0RLBSIVCWH5qJN8O
 NFYN/rR8ngvtZB9qHteWf4Df9G6zmPL5q3z8ldeYZE4ybzOPY9/SylqrzIqB/wKEgy0C+xGzdz5
 vrksfY/Ko3fk5gtQaKSxcD0VNZ5gYGGBFmuq0/K0ZLDpG7jLBN+yk7bzfCwFx8gv8ZfDlu+4om3
 tt7uNBMWUrHlNTp0ovjINgzBszmSfcEnziQc/zySAXImCo+ao6vuVfW85ZuSyk5Pvq7QFZmlPtB
 7WZwCKWPReyecFQ+tw6bMgwvLsTbOEbRD42LdyCmp9wspsE42q+vYz7/GzzoqBIcbWnd3B71sTt
 bswXwR7n4Kt3J8Qw65g30c374mrCkvjLsnsYFwANARkROvKhl2pAxav7osESuJcNNUk/z//Iec3
 jkKzJVE1lw8a0ifvWfg==
X-Proofpoint-GUID: bmkFzDFi1E67xdEzYhnqa4YUrneIUoH7
X-Authority-Analysis: v=2.4 cv=AfmB2XXG c=1 sm=1 tr=0 ts=6a54e1c4 cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=KKAkSRfTAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=tWRRbWwrKX-5tUpmLDIA:9 a=QEXdDO2ut3YA:10
 a=rBiNkAWo9uy_4UTK5NWh:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEzNSBTYWx0ZWRfXzKDmOJI8ZgFE
 8W3IgTDvQYmPIfbZQanwTR7V3haWr7NLeDeVFJUcl2PxBk470WbQ9YbtD59FdonB5XKWu03tOzq
 Av8RcMXL4KS2xDA1mKTn/xJa1OoUnZo=
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
	TAGGED_FROM(0.00)[bounces-12385-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:corbet@lwn.net,m:thara.gopinath@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:quic_utiwari@quicinc.com,m:mdalam@qti.qualcomm.com,m:lumag@kernel.org,m:mani@kernel.org,m:stephan.gerhold@linaro.org,m:andersson@kernel.org,m:peter.ujfalusi@gmail.com,m:michal.simek@amd.com,m:Frank.Li@kernel.org,m:agross@codeaurora.org,m:neil.armstrong@linaro.org,m:dmaengine@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:brgl@kernel.org,m:bartosz.golaszewski@linaro.org,m:bartosz.golaszewski@oss.qualcomm.com,m:tharagopinath@gmail.com,m:peterujfalusi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,linaro.org:email,vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim];
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
X-Rspamd-Queue-Id: 8047074B4F4

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


