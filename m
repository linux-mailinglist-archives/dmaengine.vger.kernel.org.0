Return-Path: <dmaengine+bounces-11842-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H6FTIKhDQmo63AkAu9opvQ
	(envelope-from <dmaengine+bounces-11842-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:06:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5806D8A6B
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:06:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=PTGGO26S;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=HxBdUbbH;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11842-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11842-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84DDB30775C3
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 10:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509C33FCB39;
	Mon, 29 Jun 2026 10:01:38 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA603FBEC6
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:01:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782727298; cv=none; b=pTJff9mOINMmW8Y2eLeu3Q7MG+ug0JdMih+mXF+h5A/hE5xSccMop5EOmLRBh9dMgheR/tzGIInBCr5ouMrrYLad2hdlh0/rxcwREJdRbhg+WL/gRRDJHRpFG8vW+Oeh0cyeZnFZ0/AGDbeb7xboAh8hL6FTp8A7aSz3r260ANw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782727298; c=relaxed/simple;
	bh=E5UClFUpFD2cBZbsLdWJR5rmjbc/5tNzzqVKkpQH7pc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fQ+Wqu9o/JXgNHGX4CR2ymuxcU2wdtZiGnH4g/qH9U4y0EXBieFoVrO+gu9eUx42+llzooOlp+9YKnF9jXOFy2eBfvn0u0cz5UB4gRRGEBwKj6xsseCUr2JK48lXcUvVFqWBesbVnwYa8O+UbBYBaPTdLtS/zogdvaXNbzxOerI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PTGGO26S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HxBdUbbH; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T8xEWW2447420
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=DiLxo5X9butVvuPltJCx5q
	rHl55sLp0zJC+g7r8kbbA=; b=PTGGO26Sc9ucc9yaE5Q35D3okV/Kg3PoBHCdE2
	9cmJxMGb46EDYCOEq54tMoTqOHohJcs4TD/jptbWJqlDUAwNLSz0ZqLB0G4waSCa
	zpCObqCvTmtWHQS03FCCN+QHfFmVIIEaMboSzMT4A7wdg7TJAAM2S28r5ekomZP9
	HeI2EaUyIQtQ0qewEpvgccv2uCc6325FrSx/y4irWEc9U36Y4SS01mCldlK4jy4m
	W5jwSC4rti94kDgVGYwlStbUgsJu5q3zRL85jzybn05Z4XFZp3aalJSBMH2H0p9d
	fvaqHd1G1VtOhHGxK1+xsHpWgnSnGNKQ3ceBhlHU+7n2lg6g==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3np7g8ah-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:01:35 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-9693878131dso1931946241.1
        for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 03:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782727294; x=1783332094; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DiLxo5X9butVvuPltJCx5qrHl55sLp0zJC+g7r8kbbA=;
        b=HxBdUbbHizyRQG7lnymhhsgS7SdJWG5nTso3rkih8deTCs/+qOUFupM9Tdostbvspq
         7fWpn8Q847GVxwBuby3PRk6H5l8YioA6W3ylN8zdJm7CyNo0ut8AXEc2QO1P78J7oCH4
         lE9lOp1LEbHq7/yy5y2TX5+eJpLw3CCNtdr/NfLMirpkJ8LQtmOjEqSCR78MdMVAlHZM
         HDzcZ+WV8JPp5ySwPQABbPMpHpkOH/GctKvGT+8C2lMnbdzYqlspC9tlB6CByht4oa3M
         S0Jd0/PfnqVUlPxTyfOTZocW+D/Q55gJac/TRKMxyl049IfGoLqi9DVBct/M2IPU2el/
         lhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782727294; x=1783332094;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiLxo5X9butVvuPltJCx5qrHl55sLp0zJC+g7r8kbbA=;
        b=f76wnzfAQ9iNRfH5kjpaxBCCK7ZpKSUxy2i1qXxi8Yv8Tcc16VwnMLx1UxH8GYVibq
         wJNTfPjbTaqBNfc89OPOEGk7pcKDdIszLHxz+1DcBtVaym3zIOAnKL5Ykpy1F32wn0pq
         k48M6LkUqP+i0q6x1reVEsNxb5O1WPylY5xV4wXtqzhMcHTe0QoP/QFqo70XDKqRI52g
         yYvEd+4abL++t/gW/jkcjCnQpzIMDngH58EnNVpS40rn+DwSUszQLv/ruriLtcjUnTkQ
         npxLxN0O/boAx6gmc/+dC/U6mbvquHC0jJbF2+k6dmfbL0u6sHsnOLBXSdMEPefwF7Ue
         97Iw==
X-Gm-Message-State: AOJu0YwQyn+t8k2wHDFdD22OynQLZ/h3Zdrn+GyM2QH+xbRVYcE6QKXl
	KnkCqbc13GecgqMUyX4Y2jdPCUCFlab7gmNm7ZWunKA27JgWubplWASnx21hBAmJfKg9k9+OILK
	SNLkkTU19wFXWjj31J+Pid2Ka4YqMGCCKghQ0wrLAxWb/YqH0JGh9GkkUqXcyB2c=
X-Gm-Gg: AfdE7ckaaTEbPKWcCYIY7TqY4lOY17KlP9iRBq/MonVWJX8RF2RKCOWEgcQAd5nxHW3
	WXIjUJTxuGOVxKB7nG+iSuYG7Hnx3gRB5g7N1w2Ot45CTIZSQUFhRgw4GlwCA2cSIPEtgRi5yTa
	c1vIMX4dOC1/hhT8ItGJgK0bhTuwplGNvFZoPghLKmTtZkmlGGrBF/av6PHHL/WHwkj3CMgbzT+
	GdL2EVc60kJZDlZp+VRJ/LPyoh4Gx879oazpp3fj/wiaTQzb0/+IxG7pKMRBDASTyfyx6y32aui
	X+WVwnfjFLC1hCwptvPYwKkL0QjjfrNY6+GpRmM50mwFcMx+ArB50xumTT8T2FxWlm8vdFMenWz
	cTJYaGev9VCuRglqb9n68S5xZowlBMjQDKagMKpIp
X-Received: by 2002:a05:6102:3748:b0:650:94b2:b214 with SMTP id ada2fe7eead31-7342c43f8d4mr5284306137.12.1782727294155;
        Mon, 29 Jun 2026 03:01:34 -0700 (PDT)
X-Received: by 2002:a05:6102:3748:b0:650:94b2:b214 with SMTP id ada2fe7eead31-7342c43f8d4mr5283466137.12.1782727286173;
        Mon, 29 Jun 2026 03:01:26 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4705f8ea729sm24729405f8f.0.2026.06.29.03.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 03:01:25 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v20 00/14] crypto/dmaengine: qce: introduce BAM locking and
 use DMA for register I/O
Date: Mon, 29 Jun 2026 12:01:02 +0200
Message-Id: <20260629-qcom-qce-cmd-descr-v20-0-56f67da84c05@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF9CQmoC/3XTyWrDMBAA0F8JPtdBGu095T9KD9omMSRxI7emJ
 eTfOw4NMVQ6WKDFT9LM6NpNuQx56l43167keZiG8UwdYC+bLh78eZ/7IdFABwwU50z0lzieqMl
 9PKU+5SmWPqrsAueYNXMd/fhRMg7fd/XtnfqHYfocy899k9kuow9O17jZ9qzPMaXoQdCnd8fh7
 Mu4Hcu+W7zZrQywVcOR4bxCA8E6A/DP4OyJAHdVhDNSEE2WAU3ySe7GadpevvyRFp+21PxZ/GF
 pJhjULU4WORxVCtIyaFmwsugAVQvIEs6iMAg6I2tZYm2ZuiXIYk7bHCTaKJuWXFkg6pZc4kWzH
 iVlxjTjpZ6WbMVLLRm0QQnNKQPJtCy9sqBxR71YUmHi0WMIsWWZp6VaNWHIUsIrpySXwbiWZVc
 WNO64VLpz9Kwc6OCxeS63tuqPhi8Vz6w0gCkGlL5i3W63X8H2JaTyAwAA
X-Change-ID: 20251103-qcom-qce-cmd-descr-c5e9b11fe609
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12727;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=E5UClFUpFD2cBZbsLdWJR5rmjbc/5tNzzqVKkpQH7pc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQkJj1mMnWSJ5ioOPHQtqCSCbxHsGn4ZX/p7MZ
 kx4ITTBysyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakJCYwAKCRAFnS7L/zaE
 w2FgD/9aTEPPrnzaKY27xuIpVcVIZdpmhp54URuKyZpCqhgfAAPWvxIMplbC+2mirUn+rLUqgOO
 xbuyvcbdNc9UAlwcazu9z6oQrxaOlusVx0zrcNgmCFOW1zLIPm72BimFJOVX4mEF6BECXTHazQk
 nQDA25/jCwNOvvPk6XBG8FNX02IuaPQsPAxBbDtNOrpQYNoX/qPs45+RagJ1sU4iH5m8l0g45Mo
 fXcywH0s7KSjvhqw1zSowvF9GbA6RuoPFQEFrtrbNetcANgzSsoChGFczj65MBHkdo6Oafg8z7a
 RFfwfCoZR/y8N6nJgknXGwrflCwkQdKBvhDNfuP67sOWqkhHwI2tyDEOV92Y1xJDMoLetoVrQy9
 gkNztkNcHF5A2OaWYSiREA5snT1IJVVF++aHLsDADynwuEC3ZjifEFJgKNgbyiysQbWHg/UzdLf
 QFw/qormxrOAGB7z9V+uJJLIo7Idrnv8tuRHU92DywapO6Lsd/sJA56M5BXNJVh+FkOV9stUGuE
 wBkgq8a+zoCl+c6ZuAcGrx1om5GIIaeZLkzzxlAItiS2JefGlGicsfP8tWXVvdA6tojIcRrWjWZ
 RFZG4hNDPnkvlNqGxeHRKcbV8fq7K9gpXhqeF9nSyt5lQCqC40OEstnf90qHLTIWzcbemb501LS
 4lwAGxHnD7PZXPQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA4MCBTYWx0ZWRfX5wZk7OfKZiyg
 DJB+orMCeFoN5UUDwHYB3neClr1XscX77ZahQ0phTDTUoRoDNhFQXBVE+63cAyBipWKZElslgyz
 gMFcWGU36e9tRj8t0L50YZ++oWK27Ldh5B0v3fLD8n+6og5Zz2CH6F7aQ0emIdM7vT+1QhBRSEG
 kUteWsmbt7mRR2A6fUbarzio22B7Lfk0pTrL8ipf4dFUJVWuFXCDapegi22nWwkp5rhUc/G9aYC
 caST0nsrqWuEAGAbkeY3i/7CfVe7Xsd7fPfaixicnAyDOuAc8iypHa/0r3dMjEd3OPiJxaFmkbd
 jFN2+4mRjaSgaVGQ+8FES7Z5LJn3+ZxGjk4r+n/KEukw4pL3gWNLqxZeVypdmTeNHBeCSXRmVL7
 4HMZhI39M0GRHx4909Sp+doWB4d5bd7fCKaamADUw/FaEbspTitzfBE1sz2Tyw0r59pJnUmC5B5
 FSFDIL72pqjc1R76jpQ==
X-Proofpoint-GUID: Mrz3eOca_cFl80cc2aSWMwQ_zaBIRNUO
X-Proofpoint-ORIG-GUID: Mrz3eOca_cFl80cc2aSWMwQ_zaBIRNUO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA4MCBTYWx0ZWRfX9M1+5eIJc+qs
 HYsS65LhEuxL42KRfy68Sk56qMssLPyCErBnktVe8cMuiT35O0U3NfcQ46t/ggOK/7dww5NpQCF
 kGtZM4LlEs9Z4ziE8Vz5/PF2pqTuMe4=
X-Authority-Analysis: v=2.4 cv=OcWoyBTY c=1 sm=1 tr=0 ts=6a42427f cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=mYVGbHsXlysWdROdmYcA:9 a=NpY6u6IGb6b5TAkS:21 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22 a=FO4_E8m0qiDe52t0p3_H:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290080
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
	TAGGED_FROM(0.00)[bounces-11842-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:corbet@lwn.net,m:thara.gopinath@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:quic_utiwari@quicinc.com,m:mdalam@qti.qualcomm.com,m:lumag@kernel.org,m:mani@kernel.org,m:stephan.gerhold@linaro.org,m:andersson@kernel.org,m:peter.ujfalusi@gmail.com,m:michal.simek@amd.com,m:Frank.Li@kernel.org,m:agross@codeaurora.org,m:neil.armstrong@linaro.org,m:dmaengine@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:brgl@kernel.org,m:bartosz.golaszewski@linaro.org,m:bartosz.golaszewski@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:tharagopinath@gmail.com,m:peterujfalusi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,msgid.link:url];
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
X-Rspamd-Queue-Id: DD5806D8A6B

This iteration addresses the main concerns raised by Sashiko: abuse of
the DMA engine API with wrong usage of cookies and FIFO-full
rescheduling with locks enabled.

Merging strategy: there are build-time dependencies between the crypto
and DMA patches so the best approach is for Vinod to create an immutable
branch with the DMA part pulled in by the crypto tree.

Currently the QCE crypto driver accesses the crypto engine registers
directly via CPU. Trust Zone may perform crypto operations simultaneously
resulting in a race condition. To remedy that, let's introduce support
for BAM locking/unlocking to the driver. The BAM driver will now wrap
any existing issued descriptor chains with additional descriptors
performing the locking when the client starts the transaction
(dmaengine_issue_pending()). The client wanting to profit from locking
needs to switch to performing register I/O over DMA and communicate the
address to which to perform the dummy writes via a call to
dmaengine_desc_attach_metadata().

In the specific case of the BAM DMA this translates to sending command
descriptors performing dummy writes with the relevant flags set. The BAM
will then lock all other pipes not related to the current pipe group, and
keep handling the current pipe only until it sees the the unlock bit.

In order for the locking to work correctly, we also need to switch to
using DMA for all register I/O.

On top of this, the series contains some additional tweaks and
refactoring.

The goal of this is not to improve the performance but to prepare the
driver for supporting decryption into secure buffers in the future.

Tested with tcrypt.ko, kcapi and cryptsetup.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v20:
- Don't use DMA cookies for LOCK/UNLOCK descriptors as this leads to
  dmaengine state corruption
- Handle re-scheduling of a DMA transaction on full FIFO
- Fix DMA descriptor leak in qce_submit_cmd_desc()
- Link to v19: https://patch.msgid.link/20260526-qcom-qce-cmd-descr-v19-0-08472fdcbf4a@oss.qualcomm.com

Changes in v19:
- Fix more potential issues in remove path (sashiko)
- Remove unneeded return value check for vchan_tx_prep() as it can never
  fail
- Link to v18: https://patch.msgid.link/20260522-qcom-qce-cmd-descr-v18-0-99103926bafc@oss.qualcomm.com

Changes in v18:
- Free the BAM interrupt before disabling the clock in remove() path too
- convert the size assigned to command descriptors to little endian
- don't pass DMA mapping attributes to dma_map_sg() in bam_dma when
  setting up command descriptors
- Cancel the QCE workqueue *after* any outstanding DMA transfer
  completes
- When mapping the scatterlist for command descriptors: use the actual
  number of mapped segments for dmaengine_prep_slave_sg()
- Drop the leftover read_buf field from struct qce_device
- Unmap command descriptors only after terminating the RX transfer
- Pass the actual size of the metadata struct to
  dmaengine_desc_attach_metadata(), this is not really required for our
  use-case but let's do this for correctness and make sashiko happy
- Drop double assignment of bam_ce_idx in qce_clear_bam_transaction()
- Remove unused QCE_MAX_REG_READ
- Link to v17: https://patch.msgid.link/20260519-qcom-qce-cmd-descr-v17-0-53a595414b79@oss.qualcomm.com

Changes in v17:
- New patch: free the interrupt before disabling the clock in error path
  in probe()
- New patch: cancel the QCE work on device detach
- Hold the channel lock when attaching the metadata
- Reorder the operations in devm_qce_dma_request() to avoid freeing
  memory that may still be used by the DMA channel
- Register algorithms as the last step in QCE's probe() to avoid making
  the resources available to the system before the DMA is fully set up
- Fix error paths in algo request handlers
- Don't pass dmaengine attributes to map_sg_attrs() as it expects
  dma-mapping attribute flags
- Fix a dma mapping leak for command descriptors
- Rebase on top of v7.1-rc4
- Link to v16: https://patch.msgid.link/20260427-qcom-qce-cmd-descr-v16-0-945fd1cafbbc@oss.qualcomm.com

Changes in v16:
- Fix a reported race between dma_map_sg() called with spinlock taken
  and the corresponding dma_unmap_sg() called without it by moving the
  descriptor locking data into the descriptor struct
- Also queue the TX data descriptors before the command descriptors to
  match what downstream is doing
- Tweak commit messages
- Rebase on top of v7.1-rc1
- Link to v15: https://patch.msgid.link/20260402-qcom-qce-cmd-descr-v15-0-98b5361f7ed7@oss.qualcomm.com

Changes in v15:
- Extend the descriptor metadata struct to also carry the channel's
  transfer direction and stop using dmaengine_slave_config() for that
- Link to v14: https://patch.msgid.link/20260323-qcom-qce-cmd-descr-v14-0-f323af411274@oss.qualcomm.com

Changes in v14:
- Don't return an error to a client which wants to use locking on BAM
  that doesn't support it
- Add a comment describing the DMA descriptor metadata structure
- Fix memory leaks
- Remove leftovers from previous iterations
- Propagate errors from dma_cookie_assign() when setting up lock
  descriptors
- Link to v13: https://patch.msgid.link/20260317-qcom-qce-cmd-descr-v13-0-0968eb4f8c40@oss.qualcomm.com

Changes in v13:
- As part of the DMA changes in the QCE driver: reverse the order of
  queueing the descriptors in the QCE driver: queue command descriptors
  with all the register writes first, followed by all the data descriptors,
  this is in line with the recommandations from the BAM HPG
- Set the NWD (notify-when-done) bit (DMA_PREP_FENCE in dmaengine
  parlance) on the data descriptors to ensure that the UNLOCK descriptor
  will not be processed until after they have been processed by the
  engine. While technically the NWD bit is only needed on the final data
  descriptor, it's hard to tell which one *will* be the last from the
  driver's point-of-view and both the downstream driver as well as
  the Qualcomm TZ against which we want to synchronize sets NWD on every
  data descriptor,
- Revert to creating the LOCK/UNLOCK command descriptor pair in one
  place now that the NWD bit is in place,
- Link to v12: https://patch.msgid.link/20260310-qcom-qce-cmd-descr-v12-0-398f37f26ef0@oss.qualcomm.com

Changes in v12:
- Wait until the transaction is done before queueing the UNLOCK command
  descriptor
- Use descriptor metadata for communicating the scratchpad address to
  the BAM driver
- To that end: reverse the order of the series (first BAM, then QCE) to
  maintain bisectability
- Unmap buffers used for dummy writes after the transaction
- Link to v11: https://patch.msgid.link/20260302-qcom-qce-cmd-descr-v11-0-4bf1f5db4802@oss.qualcomm.com

Changes in v11:
- Use new approach, not requiring the client to be involved in locking.
- Add a patch constifying dma_descriptor_metadata_ops
- Rebase on top of v7.0-rc1
- Link to v10: https://lore.kernel.org/r/20251219-qcom-qce-cmd-descr-v10-0-ff7e4bf7dad4@oss.qualcomm.com

Changes in v10:
- Move DESC_FLAG_(UN)LOCK BIT definitions from patch 2 to 3
- Add a patch constifying the dma engine metadata as the first in the
  series
- Use the VERSION register for dummy lock/unlock writes
- Link to v9: https://lore.kernel.org/r/20251128-qcom-qce-cmd-descr-v9-0-9a5f72b89722@linaro.org

Changes in v9:
- Drop the global, generic LOCK/UNLOCK flags and instead use DMA
  descriptor metadata ops to pass BAM-specific information from the QCE
  to the DMA engine
- Link to v8: https://lore.kernel.org/r/20251106-qcom-qce-cmd-descr-v8-0-ecddca23ca26@linaro.org

Changes in v8:
- Rework the command descriptor logic and drop a lot of unneeded code
- Use the physical address for BAM command descriptor access, not the
  mapped DMA address
- Fix the problems with iommu faults on newer platforms
- Generalize the LOCK/UNLOCK flags in dmaengine and reword the docs and
  commit messages
- Make the BAM locking logic stricter in the DMA engine driver
- Add some additional minor QCE driver refactoring changes to the series
- Lots of small reworks and tweaks to rebase on current mainline and fix
  previous issues
- Link to v7: https://lore.kernel.org/all/20250311-qce-cmd-descr-v7-0-db613f5d9c9f@linaro.org/

Changes in v7:
- remove unused code: writing to multiple registers was not used in v6,
  neither were the functions for reading registers over BAM DMA-
- remove
- don't read the SW_VERSION register needlessly in the BAM driver,
  instead: encode the information on whether the IP supports BAM locking
  in device match data
- shrink code where possible with logic modifications (for instance:
  change the implementation of qce_write() instead of replacing it
  everywhere with a new symbol)
- remove duplicated error messages
- rework commit messages
- a lot of shuffling code around for easier review and a more
  streamlined series
- Link to v6: https://lore.kernel.org/all/20250115103004.3350561-1-quic_mdalam@quicinc.com/

Changes in v6:
- change "BAM" to "DMA"
- Ensured this series is compilable with the current Linux-next tip of
  the tree (TOT).

Changes in v5:
- Added DMA_PREP_LOCK and DMA_PREP_UNLOCK flag support in separate patch
- Removed DMA_PREP_LOCK & DMA_PREP_UNLOCK flag
- Added FIELD_GET and GENMASK macro to extract major and minor version

Changes in v4:
- Added feature description and test hardware
  with test command
- Fixed patch version numbering
- Dropped dt-binding patch
- Dropped device tree changes
- Added BAM_SW_VERSION register read
- Handled the error path for the api dma_map_resource()
  in probe
- updated the commit messages for batter redability
- Squash the change where qce_bam_acquire_lock() and
  qce_bam_release_lock() api got introduce to the change where
  the lock/unlock flag get introced
- changed cover letter subject heading to
  "dmaengine: qcom: bam_dma: add cmd descriptor support"
- Added the very initial post for BAM lock/unlock patch link
  as v1 to track this feature

Changes in v3:
- https://lore.kernel.org/lkml/183d4f5e-e00a-8ef6-a589-f5704bc83d4a@quicinc.com/
- Addressed all the comments from v2
- Added the dt-binding
- Fix alignment issue
- Removed type casting from qce_write_reg_dma()
  and qce_read_reg_dma()
- Removed qce_bam_txn = dma->qce_bam_txn; line from
  qce_alloc_bam_txn() api and directly returning
  dma->qce_bam_txn

Changes in v2:
- https://lore.kernel.org/lkml/20231214114239.2635325-1-quic_mdalam@quicinc.com/
- Initial set of patches for cmd descriptor support
- Add client driver to use BAM lock/unlock feature
- Added register read/write via BAM in QCE Crypto driver
  to use BAM lock/unlock feature

---
Bartosz Golaszewski (14):
      dmaengine: constify struct dma_descriptor_metadata_ops
      dmaengine: qcom: bam_dma: free interrupt before the clock in error path
      dmaengine: qcom: bam_dma: convert tasklet to a BH workqueue
      dmaengine: qcom: bam_dma: Extend the driver's device match data
      dmaengine: qcom: bam_dma: Add pipe_lock_supported flag support
      dmaengine: qcom: bam_dma: add support for BAM locking
      crypto: qce - Cancel work on device detach
      crypto: qce - Include algapi.h in the core.h header
      crypto: qce - Remove unused ignore_buf
      crypto: qce - Simplify arguments of devm_qce_dma_request()
      crypto: qce - Use existing devres APIs in devm_qce_dma_request()
      crypto: qce - Map crypto memory for DMA
      crypto: qce - Add BAM DMA support for crypto register I/O
      crypto: qce - Communicate the base physical address to the dmaengine

 drivers/crypto/qce/aead.c        |  10 +-
 drivers/crypto/qce/common.c      |  20 ++-
 drivers/crypto/qce/core.c        |  39 +++++-
 drivers/crypto/qce/core.h        |   7 +
 drivers/crypto/qce/dma.c         | 173 ++++++++++++++++++++-----
 drivers/crypto/qce/dma.h         |  11 +-
 drivers/crypto/qce/sha.c         |  10 +-
 drivers/crypto/qce/skcipher.c    |  10 +-
 drivers/dma/qcom/bam_dma.c       | 270 ++++++++++++++++++++++++++++++++++-----
 drivers/dma/ti/k3-udma.c         |   2 +-
 drivers/dma/xilinx/xilinx_dma.c  |   2 +-
 include/linux/dma/qcom_bam_dma.h |  14 ++
 include/linux/dmaengine.h        |   2 +-
 13 files changed, 468 insertions(+), 102 deletions(-)
---
base-commit: 80a4205b805dd461d0a5b5c684079bb120df96d0
change-id: 20251103-qcom-qce-cmd-descr-c5e9b11fe609

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


