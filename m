Return-Path: <dmaengine+bounces-7380-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A744C91F28
	for <lists+dmaengine@lfdr.de>; Fri, 28 Nov 2025 13:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B296E4E518A
	for <lists+dmaengine@lfdr.de>; Fri, 28 Nov 2025 12:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D1A328603;
	Fri, 28 Nov 2025 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wl6wxasr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b8PD3E/f"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461AF3101B8
	for <dmaengine@vger.kernel.org>; Fri, 28 Nov 2025 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764331744; cv=none; b=quJeBWZlClOn/lVsedX5s3P0os9QSXdoet1mMdvQtoi0mzzunoGc/N4iw9a/8tzxNbZPbsfz5yHayrkYYEEcuZ+X56QzTUwhNCarAtvcWmSATNgpyiiEew6N+SrDcrxo73/MRqQCNB+oolabEuv9rw7edfsqT0neayuG1CCCqQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764331744; c=relaxed/simple;
	bh=ueLyq46JDjBihegO9qj7nvGBPhhfHALgUnFEM90Acb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T2ERwcbt+AXD5mI+lewEHJHDC62XMkobH52v94w0x3pWS54ZfSVOBQ0HGEdmSUgJW4n4uFw/FT6F8gPj4T+ESVHfymNOaxBdj2Vn8bMeV+8obIbyJGWwRlLSBJFC5HpFaIbMxlXHsWD9etlUONuIxT7iETk2iHLmdBWj9wCKVHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wl6wxasr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b8PD3E/f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AS8PWr83797333
	for <dmaengine@vger.kernel.org>; Fri, 28 Nov 2025 12:08:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/AMvgGr+A3VUPf83LfDwUwYIePu0GXYwS7q7hJotv5M=; b=Wl6wxasr5uWhH+yp
	XGPWcbtqtx3qebtX19hT3w1qs3t9v0S3K3pr1tjIk7DLXghxMbb9Eg1vsYLa6esK
	mmY+61Y+msMzPumjPb6Jy96QxhIRl63IaVlVgh8WKtB+XiQVVz7Me6qM8cORra/J
	aNWsWRn59rYFGsiPiF7oDUrRkpBSkJuUtIhfkXbBGqsW33EahkMOsumFfgqa7sjh
	YVZXzdOoNbiz6yM+JnTqYZHifIe30h7Uq816FA6vuca9wxj+gibSle85lB6R2MxU
	W0Toc8vZiTvE83l1WPTAV43193Zdf2fDHx3uit/kfDy52d99UtcBgX+EABLPElvO
	oOoM+g==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4apnudb2g9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 28 Nov 2025 12:08:56 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5dfadf913a8so166542137.3
        for <dmaengine@vger.kernel.org>; Fri, 28 Nov 2025 04:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764331735; x=1764936535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/AMvgGr+A3VUPf83LfDwUwYIePu0GXYwS7q7hJotv5M=;
        b=b8PD3E/feg97Q+2BT/fuMKXXX78hgaq4Ew1SKiVH1iFrUXzq7r+hcoVAa4PuL3H9RF
         7UogfU+yXUMzQMrWk6fsjQS2nInyf1UR7galFJZrC7q+3DlLX6B+/D1OOK7TogAGsB5P
         SWwjnkF1zHEbqbB68Y2LN8XJDeXnDNBLP3vjmBDwCsVD9HYDtiSh+3d8RZPP/o5+bCO1
         gkPgc+XdqrQQ8tgV8d+1TOVm79oA3yW/otfA76/WmDfRB5PnYxdhbFV4YNqWBpzPFCs4
         RhXlIB4zC7hoqDT32xVtlr3oSPvKZtyrxEcbDy800/QNbavDVgKx8K4n6Nt4CmseCMat
         1GIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764331735; x=1764936535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/AMvgGr+A3VUPf83LfDwUwYIePu0GXYwS7q7hJotv5M=;
        b=hcc19mJOvEQVFuRh4RdXIKWlfpbORAtssod2jCBSjjizY+WsXlE/VLLM5NUbMdw2gy
         gweB8/B5dGgJqm3SicmPQYR3DhjSP9gUdPhN+u8GsfXIMNYYyoo3djbvCHreU/oFMH48
         Wll9Yweb+5YD1jNkzFTsO1swbCCrHXUQPDETOShx8SYPEmgOUOlSxcFx2MZmHxPYkQuB
         Hu9Ug+Xi4xxoTRKJiYWkda4j4UI6Aiy7uUs8JxWO42X2NxmKtXbhdRCDKrFUmg21H73P
         +OBp76/FQvcbmH6jdRfL2HloRkzwCTn+uuO/dWvX0g8+vF3Ws58LyLAP6LuOYl290k9R
         yKvA==
X-Gm-Message-State: AOJu0YwD7JdNqnMHmtGibhCZjKDdKuHUzR0Jh4rUhku9ofSrMIrJ5mHi
	bZjYka6Upp4VHUMJuRw1wMELUpPKTz6zubyjH2ixfsEgJ2qxiOb4PUYoTtv6wXmk+xJnz/6aifm
	q/X/MLuA91Jf9N1bU/S6PMqqC2Esg438OvvN5ebnOr/yLgn90he4vZprPS1lgKrY=
X-Gm-Gg: ASbGnctZTV74C/wuZ6BB6wpK2s0aORTG16Z73Wnkfxln4beHQe4g/ulUrtTFftPtofc
	4IV5oHIJMKY8FlnXZiyQx73584bs6SqBwziHtMDswSbhK3WK8sRo22abgOMYN1CD+yB4yOu6mpR
	0ACMNXLQfoBXUjj3PWtp+4w9GzR0byoZYWmRZgU1anMbyJZqZcWIGzeoi5N1sxMp8kIO2tjqomv
	YYCHOmZ157ANk3C3DRQiV1Goy2eJhAuKtw9CL7U2lvNSz2cvRvYyrFF9QqJsZfwi2GTZWaACqYW
	FPedxY8BgOcTHHdC+Y1ZeF6/YK0DV9KxGA2yUvjr6kHzWpSVLpYOzVUdl5xZieSr2jVDhnduhXh
	QcF+J/1pswToJsghZSasye4qOBSpTBffNBogQB1N7rvAwAAfmWg2Gem5TvRCzkHuL9jI=
X-Received: by 2002:a05:6102:4420:b0:5df:c33d:6e58 with SMTP id ada2fe7eead31-5e1e617ee0cmr5243515137.0.1764331735643;
        Fri, 28 Nov 2025 04:08:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcDNhnYB3uQVovzvtUAgWZaPKJAKjhvoad+skVmq1ako0hV88tZALhYbd+C4wBmEePnEEdrQ==
X-Received: by 2002:a05:6102:4420:b0:5df:c33d:6e58 with SMTP id ada2fe7eead31-5e1e617ee0cmr5243461137.0.1764331735249;
        Fri, 28 Nov 2025 04:08:55 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5162088sm432375166b.1.2025.11.28.04.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 04:08:53 -0800 (PST)
Message-ID: <afde1841-f809-4eb2-a024-6965539fcb94@oss.qualcomm.com>
Date: Fri, 28 Nov 2025 13:08:50 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 11/11] crypto: qce - Switch to using BAM DMA for crypto
 I/O
To: Bartosz Golaszewski <brgl@bgdev.pl>, Vinod Koul <vkoul@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Tiwari <quic_utiwari@quicinc.com>,
        Daniel Perez-Zoghbi <dperezzo@quicinc.com>,
        Md Sadre Alam <mdalam@qti.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20251128-qcom-qce-cmd-descr-v9-0-9a5f72b89722@linaro.org>
 <20251128-qcom-qce-cmd-descr-v9-11-9a5f72b89722@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251128-qcom-qce-cmd-descr-v9-11-9a5f72b89722@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: QSrmxDEwM6qGI2B7cVZOZwg1kBcbEIjs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI4MDA4OCBTYWx0ZWRfX5uTP8tnz1raJ
 eWQWf5jb42nHx6QKyqDvzB7wynp53HBr2LV78f9pd8Bus9uba6ERRhnlR9nS2XpKyJ01brGBl9p
 ngm6TFIjsKgn4ZvYet46c+pQQBlvvHM+4mwMdW8LZrV1fVIRJ7cI7BQbjvpfponnjOb5fLiRUmB
 NlRMxn3g80k54ahkYBBousNzKgzQQVA0mBbPHVlq8mXhdNfbRtXWDBK0KsXniG0L2CtcbmNgK82
 8jtyGQCW1X2xEhWJMHYogIFLDp3yz0zEnsE6Mgf5LItQXDg5k/a7nZEXXM9l81LuwoE3Lu3eYud
 M25+Q2T4MPj/9ZnSrWaSgtBcbVMUPtR3ACm8Mj3hgTtJ+THRYgKmk0O1d8lJzt7MhZPdmRsF0kS
 iG6D2dwz3nyPwXTQGVh8tJSd+iFQDA==
X-Proofpoint-ORIG-GUID: QSrmxDEwM6qGI2B7cVZOZwg1kBcbEIjs
X-Authority-Analysis: v=2.4 cv=MKNtWcZl c=1 sm=1 tr=0 ts=692990d8 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=wXQIig4NBtMv4ZYXLh4A:9
 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_03,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511280088

On 11/28/25 12:44 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> With everything else in place, we can now switch to actually using the
> BAM DMA for register I/O with DMA engine locking.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

[...]

> @@ -25,7 +26,7 @@ static inline u32 qce_read(struct qce_device *qce, u32 offset)
>  
>  static inline void qce_write(struct qce_device *qce, u32 offset, u32 val)
>  {
> -	writel(val, qce->base + offset);
> +	qce_write_dma(qce, offset, val);
>  }

qce_write() seems no longer useful now

Konrad

