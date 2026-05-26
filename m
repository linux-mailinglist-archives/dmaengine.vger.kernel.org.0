Return-Path: <dmaengine+bounces-10939-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LYFLDyeFWr9WgcAu9opvQ
	(envelope-from <dmaengine+bounces-10939-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 15:21:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBB35D64B9
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 15:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 372803178A23
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 13:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481F83DC4A8;
	Tue, 26 May 2026 13:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oVUH4pur";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IOFaIr7r"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D08C2D6E58
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 13:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801083; cv=none; b=XFFqklg9zD/q6TBdJTP06rM2EK6iRFbJbtDd8JRs6oH4g6E13C1yvJaKBKM3hXIy5PVauvegVLig1W30oyJMUTZ2sTKs9eilWYr7kYSJTcQJBOCu9z+9pIGiWhb82vc6m47uoV8kwdivJSpaPhNUYhXmeOZDXiAyCVSWjn10tts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801083; c=relaxed/simple;
	bh=sbAZ0uSKUaRdnyGLlPY1ufhZQffFEqw4Dc+bpCN2u5o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BjknHEA38xovTyW7UTHSdvFQeO3oehPZM38lMkERzNKBciu9wgYA8E2Op+jr/lMBQWB9ppSji9RbzdKX7kiv8j0P3DUv0HNkDUM94XhjXiteR95NE5TIpZ/KOtnHEx9Ubag8V4R010IxY45HN7TiLM+GfUgRF1oWZtMskhMTChs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oVUH4pur; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IOFaIr7r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QCsNd22705368
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 13:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=iguqntH0XAVATIYTkYE5lY
	3ju0GJcUk/uklTpcBYCfU=; b=oVUH4puryldQH3ThO3DWrt7bypSSoI1NKGuxbM
	XXD27NERJx4w5R6MXvTBjuYwTt6/DfzgRN9b8/d3Y891DdYcoKrS2W1zhtuu5KDx
	+6OXWhLhoKqS6vgwwwu2hH5yHr6lhvVSL4SI1h11R1l0JDO2OAwRvWtUP6uxUb0S
	w9+PpX9GP9e5TSi402+3O5yMjQfeICPcjS4ru6xzOqgt/5J9MeFN7zASF2z/imBd
	O+Tq67N6ZPhBG3uwfHyt3LGcWI6g7deev4b4P7glH5BKDorRimJ8lMzxAQJ4o99n
	Z3noYGg1M7hc1saKCgROVFaFimAjb3Ss2egaKCQVm5XT0gSA==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ed5vghvhp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 13:11:19 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4855c24b89cso6454538b6e.2
        for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 06:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779801079; x=1780405879; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iguqntH0XAVATIYTkYE5lY3ju0GJcUk/uklTpcBYCfU=;
        b=IOFaIr7rS4Tu+EsW9jmPrMPpKDw7L7UrLMBILKO4l+VwbUP6BLV85ZMN5CKapicZ+6
         Gr3gMqGqiuuuQkFZRFx2T7dzzFOBDyW+JDhLhx+HE3Ts3IZQI+qq6PsgoKo9EoBp2eYE
         MqsYOpT29lj3pIc3TZHyWyWkotokxk6Ejt4hxmXypF0cVs3cMSVR0kHCX0/kRrhcqmLy
         GAEf3qY4nt7m423M2n7uvs2BOhflFM4LnSteFHcQxiayezAL8gBpLdGKNdV0i59y1c2B
         Hv0nCgl4B3v/i7y58vulClqKjhXEAY2RJ3QZ1ihEsSYHAA65lu3/8t3ouO+xupSnOK0Q
         pyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779801079; x=1780405879;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iguqntH0XAVATIYTkYE5lY3ju0GJcUk/uklTpcBYCfU=;
        b=Om2NOywPPXp7iqNCgmDWwbc4fIf5yPC9tgFya/GXsWszyUEXqoGAGfObJsWVXCKo7V
         B/ClbzYKAoHN1ardhPSiQhQ7ZCJ1iERFc39PbsFkHRPXfshxIgaSU+/U3BxCiE2DM1OI
         BfbHm9oNQAhn09skQOR4QVLsIBsylrLjmsBdUrC9xOa63CYHlxRYgS0Sf2DqgLwngFjH
         QvR7oWc+pF8CXX0at5TCpcwLzVeCJtTMlNFmw+uPNgVSaDwJRAljyAFlvsUk/AFfad36
         N62zXkH4OQiOO/DHZlfkkJ4cOI/3CMwwLSAFt8AWmlJJ6FZR21OcEjfBRoNOLBttjiSe
         enbw==
X-Gm-Message-State: AOJu0Yx2VRjQdBSOKy/+feqJX39qFUuRq58RCO3Oh62jzehnpvU79r7X
	FbEr8xyR53WdzBK+MaQfMTl/7OJeU9WWgKt0O2fRwpOY7Km/v0xIebgkUQyA5SvVlxSFBHWmJkD
	114L4u0Jd+U44lMX6MFiB8Vgysxr7h+OiMBbZiYRvSs7XEqvZYY5q0uFrrYWftPw=
X-Gm-Gg: Acq92OHmrGRgV/vlM+8dXnygLwKvdfFsoS4WWh0kkamJF7UWX0gTwLJY2Ipy+QPFALc
	vr8cza7aRCj7f9zu2HxhxkDD5QmHSbwRj+XMmn9mIHdxp25pqKEUPkmYNiihHsgzOo89F/5o/0r
	MZEtPCQfd3dR/p20B+wOxZVPKSpdACahpPkYDX3N0U6KN2sBusBbJYoqMs/stVXJKpCZTOkGV/K
	8ePBt1E96gB4i6iCO4N7VRWyPXCOEU96M1AYxGJDItHM8IKLyh2OhG++g0PuXvZVhD4N2mqbzTg
	sLuD/ZwLay0ZVpzpkp9qBNgK3cXT9Omgp7e5pmW1gjpVTX9gWIdBMgxUw/heImQUFoU8IpHLWAS
	Wsw+C/eTbu6YPKeKF7adtwOwpFmPmtUsmob2rKaltkWR5OQQ1ukE=
X-Received: by 2002:a05:6808:238c:b0:474:28c1:4877 with SMTP id 5614622812f47-4854a243accmr10250754b6e.39.1779801079073;
        Tue, 26 May 2026 06:11:19 -0700 (PDT)
X-Received: by 2002:a05:6808:238c:b0:474:28c1:4877 with SMTP id 5614622812f47-4854a243accmr10250725b6e.39.1779801078573;
        Tue, 26 May 2026 06:11:18 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:15ba:1d70:65ea:9578])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5e484sm34259426f8f.30.2026.05.26.06.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 06:11:17 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v19 00/14] crypto/dmaengine: qce: introduce BAM locking and
 use DMA for register I/O
Date: Tue, 26 May 2026 15:10:48 +0200
Message-Id: <20260526-qcom-qce-cmd-descr-v19-0-08472fdcbf4a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANibFWoC/3XTyW7DIBAA0F+JfK4jGPae8h9VD2yTWEriBrdWq
 yj/3nHUKJYKB5DYHjAD127KZchT97q5diXPwzSMZ2pw97Lp4sGf97kfEnV0wEBxzkR/ieOJqtz
 HU+pTnmLpo8oucI5ZM9fRwo+Scfi+q2/v1D4M0+dYfu6bzHbpfXC6xs22Z32OKUUPgoreHYezL
 +N2LPtu8Wa3MsBWDUeG8woNBOsMwD+DsycC3FURzkhBNFkGNMknuRunaXv58keafNpS9Wfxh6W
 ZYFC3OFnkcFQpSMugZcHKogNULSBLOIvCIOiMrGWJtWXqliCLOW1zkGijbFpyZYGoW3KJF416l
 JQZ04yXelqyFS+1ZNAGJTSnDCTTsvTKgsYd9WJJhYlHjyHElmWelmq9CUOWEl45JbkMxrUsu7K
 gccflpTtH38qBDh5r57rdbr9mVqTfpgMAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12772;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=sbAZ0uSKUaRdnyGLlPY1ufhZQffFEqw4Dc+bpCN2u5o=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqFZviwy+7CeUn2mWnnD2IfjRJa1qnTq2rTbi4l
 eHenVJt1bmJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCahWb4gAKCRAFnS7L/zaE
 wymGD/0fXUlBAs2rECINXxr3FfMDnEGRrWBA1MNGB60FWnC8yt+khqbF/yOMOXQTQh8m8rS0TN0
 oe13vgamN+gwcMSbR8ydHWrFW5LtPU/qD+JxMUYN79nyDaqH8moBgXKlOmC2WmFnHwsX1FX8iIy
 ID95N2K4fiiIC2SGdGJtbWLmDB8yV0qWwVXOrOlG/T9Qr6Mzd/t9j833GctJgNbYjcw/LDYXYXN
 XOqJFKMetV+DmdL98mG/D2QWcZ6cen+nfGzswfFW5F4df3i6FoBWRdwRJyKEq+u0ms6QkxyRN+v
 wjGIARVDtmBKj33nW3gkEFwFocPLIHLvE1UrPdyYG4Urk6H6AgHn1oxTdJw/dWYYgjvumoguL7M
 NqhhYglEE9hvRscqI/NCTX7861PqUFU2RHtSW+/b5+EmyUW5wApgfVXYn8a6F8Bzulkw+NHO/d0
 td03jOF1ZH98GY0VojjEq6V4TjnDsNx+3BMXXd9ASTlWyHVsYx3iPX7o75Wx25ZuA+RL6Q9du2m
 s45bM17YRIttiEeBv2Jefj/uXoJSO8bR0TaH5tGaXc26DrctYO/RPJn0CNJKlKeTNJtFPAqvl5v
 lraxwJ93PVxquimX3d+F895aqfEeWNljRRjQNHelRgOzmTflS3pAses/MruCtT5/Uo1QCEHJwxN
 DPLQeR9f0sBoKNQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=IrYutr/g c=1 sm=1 tr=0 ts=6a159bf8 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=mYVGbHsXlysWdROdmYcA:9 a=jo0wICh4R9D0jo7k:21 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22 a=FO4_E8m0qiDe52t0p3_H:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 3aMuwKcpwpfxEhpoZTeS2HSPp-NAAJLX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDExNCBTYWx0ZWRfXwM8J75XLSIee
 3ZgkSfV+VhcjP52DxoXVXvRvXQQaal8jGiN1I0vu5VGUh1h/Kc5tF4m8ysRyBwReRukQjWO6CY6
 QtFC8fOhlq2sOfJsqSDtNRhFKZZxtj1lEqjvse+X7hlPrD9LiixkJ/ut1xrkh9hTzhr5y/fUORk
 +K62namO+Dmjb33J0GZz/Mhd2ud7JvKaAvfnCvl9F1W8GtXdrGMjoUBo4a8urnJ5I+qJVraxuxB
 mxDj0q/isYTdEgeoRkgrc6j3CFkLCksjAz7DiND9XQ2Cs/GzRVRA3PIcwSZ1Rmd8DMr5ZMCDrFt
 jdmRLszZiEfhqUYEsA6NDc0YjtYbaKvTQIsS9i4mOCAibOh2EsNGn3k/NRcBwz8atcRvYOUhmY6
 CgmVfUk/VmMIJGafk+XVKm33+DiBDDAu+nXELmgydoHRMbK/7scgIugQHMPRlawkgKfXvTWg4rt
 doJJ0fCiO43dPqZvHnw==
X-Proofpoint-GUID: 3aMuwKcpwpfxEhpoZTeS2HSPp-NAAJLX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260114
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10939-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
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
X-Rspamd-Queue-Id: 1FBB35D64B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I feel like I fell into the trap of trying to address pre-existing
issues reported by sashiko and in the process provoking more reports so
let this be the last iteration where I do this. Vinod can we get this
queued for v7.2 now and iron out any previously existing problems in
tree?

Merging strategy: there are build-time dependencies between the crypto
and DMA patches so the best approach is for Vinod to create an immutable
branch with the DMA part pulled in by the crypto tree.

This iteration continues to build on top of v12 but uses the BAM's NWD
bit on data descriptors as suggested by Stephan. To that end, there are
some more changes like reversing the order of command and data
descriptors queuedy by the QCE driver.

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
 drivers/crypto/qce/common.c      |  20 ++--
 drivers/crypto/qce/core.c        |  39 ++++++-
 drivers/crypto/qce/core.h        |   7 ++
 drivers/crypto/qce/dma.c         | 168 ++++++++++++++++++++++++-----
 drivers/crypto/qce/dma.h         |  11 +-
 drivers/crypto/qce/sha.c         |  10 +-
 drivers/crypto/qce/skcipher.c    |  10 +-
 drivers/dma/qcom/bam_dma.c       | 227 +++++++++++++++++++++++++++++++++------
 drivers/dma/ti/k3-udma.c         |   2 +-
 drivers/dma/xilinx/xilinx_dma.c  |   2 +-
 include/linux/dma/qcom_bam_dma.h |  14 +++
 include/linux/dmaengine.h        |   2 +-
 13 files changed, 427 insertions(+), 95 deletions(-)
---
base-commit: def113ae602a35ab7a1dc42a6c43188e180287be
change-id: 20251103-qcom-qce-cmd-descr-c5e9b11fe609

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


