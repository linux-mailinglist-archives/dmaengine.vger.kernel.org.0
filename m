Return-Path: <dmaengine+bounces-10855-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YE0DMecXFGo4JgcAu9opvQ
	(envelope-from <dmaengine+bounces-10855-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 11:35:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BD25C8AE3
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 11:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A321302803D
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 09:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7D93E6DC3;
	Mon, 25 May 2026 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T8bmYpAb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cRbOlsnv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19623E51EE
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779701648; cv=none; b=EIqoUazf4zbx2r+73iriHb15QtCAlcRZ6wLeWLh1uRRuX6sjee/kyM9l8aHXBQRy6wVLJXUT9LqB+TO6gnu9+VpC3INcDSBZKfYw7XwWgy1AIEIiFioYet8ELXeqrj+30EEz65rT1S04+loDycaiz6z3AkvV4LcN238oR/L2PKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779701648; c=relaxed/simple;
	bh=XjaiCpeCYWyNVEErorwgmD4dKb39eRk0O83gVF2YfVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXbyae/v5GyY3Fc163io80m0721gSnKKySfSWTTuC02tob0IDHfb0RgwyUNBOw4lZqemKdeiJOLro3Sq7/s4ukIFQc3JEYHbDaajIyvDBDbzS5KzNGHcN3Eb0kC8ApEKlLi3OFN4EmTFz6eBVOxJFxzMY0NIKCuzFnZeDGGntiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T8bmYpAb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cRbOlsnv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P7jOZU745116
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 09:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FbNMQjBTSJaq94GvKwR19KG/
	gst5Dr26hUgZXOVVrh0=; b=T8bmYpAbIcntCDeLhgj8YsFoBnr5SMk+nbZpLmAR
	Pn3/VsbCihzuzOTQXVPgNqcJT5FUz9VXaSLcnouyPKZjYyAhz9PPkAB97rx5qp16
	vhH1p9FXAM8TTc7AO8Ytcyk53aNdyClqi/2FBUc/hc9tnsLjKYfBSG9RC7b44evu
	sM73KEeEWO9YofOejpU6Vt9EI3qJOoxlJ1315wTJ/552MFYnH9w2ql4wkt8WGr8X
	bRNMqhaTUy5aybtYzivoxND9axeLpHOD5s2RWrGDMQvJsnQylAdUozvFbh9GRRor
	BGWjVr6FQpKXZblIrCwbyPWiIJW3NrRUDqHpCnMhZ28mIg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb5h9nvrj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 09:34:06 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-516cde13e8cso81577731cf.1
        for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 02:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779701645; x=1780306445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FbNMQjBTSJaq94GvKwR19KG/gst5Dr26hUgZXOVVrh0=;
        b=cRbOlsnv3jM+mNN6KCKzVjwGSyAbta8wwYkeTqsZU+O+KmysA6R5mY+FGikw4cdEMi
         7mcvcAjIFcfLlqGqkV9sjJEzalexeAtmKXHlJQrnIhv1O9onl7xEcJA9+lN5LixXp9U+
         vmaVqHKt753qtqBGG8X+/5o8YF/obpJK5jWKptpy8lYPLE4eCAOydfU0sn8GXZS9LJuN
         pYvfYnW8FnlXl4m19HE65VOVRjF8eTml+N5uXd5ZC41kMZ2/5Axg0tOJJkuyFmuGs8uE
         iKN1oV+i9kQcLhrqQOwcMVfFj/klUQ1WJYqv91l9L8latS/zE1ZYnG6PmsijmlXQM4FL
         FwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779701645; x=1780306445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbNMQjBTSJaq94GvKwR19KG/gst5Dr26hUgZXOVVrh0=;
        b=IotOck3OCY4F0cbRL2I9D0DNrQifE5l0tYu9bWWLo8Qa7pLncXS1DVFkhf8eNPaBiG
         iHWuCLu5Hd8xADWTdQrcSSll1kHO8VgSZRvDrI21XoZTeIAs1K+XkEJDgpx8cbR7T+VH
         b27xLbEzXoQsVR/wRelWH9OHa0VWshw1RtSNS4slndwHpdpjag03wou/a1K9EWUaiYnv
         r7902YpM6Ouwiua5yPDc28dtSrPEtYrM+OijHkO7sE8WMNzzr3DzGJm2Ef8DCcHIxkk2
         DObkhpekdQ7MKCN6Nc+96Bf39MoUt96aaF71eavbgmjZ/kpaaUwS8KHhv762+mRFKrIO
         JkGQ==
X-Forwarded-Encrypted: i=1; AFNElJ+oWHwmdxS2mxpaEaptcgEjxmDeGnUt15t5FbDipxUZlLNAM5404omdDF7vfd3APeWpXv+gXhzQ1DM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywaby9sZS1Q5uIJcoWDenRoSQanAIUz4lj7PB1SyPsBkROe7k+W
	hUokfz9S/Ppe1S5xtgJce62fkFb8DfLFZfW8437VDWcvJ2Ixiz44L3m3n0U7w4jlTqkoEKPfUyJ
	FkWsubGM1ynLFMjl3HDG+bW2vhU5Uq1sHvYcwSzuREg1q4RnJF8knGGn8EM6tNr0ZlsTWz3YlDw
	==
X-Gm-Gg: Acq92OEjH/x9UQdwUpdAGst7wbF66IrdmF/v8dUk2u+gpSUj2A4455MXzo4k4/dpFsn
	CyfqRssNugxDAUIMVyylwN63g9s8Im2p4qftFYBfOiT9dAwclGL6y12myU9K6oKNy2EUVVgPFPi
	WpI8WrCQSOMDigSH6XzU1FXfYmYxpM/ZZZ5fX5EerNoqyJpbzhGPEpJfJccuwdy9KvwrtpzqIYZ
	SB8PiGcC+kC2NlLYki1jQMLVy4gNKwXyRWBjlzHl/LnFs4IvkqTbZ+E4h7+I11/7T7XIwu+Fz4N
	/L4XDwt6+DpV9nn1Lpc1FXAjtMY0l7vhV4QBKX3ypGZC53z9r0l4L1Q8ohTDI314YKPXLbNrLzM
	eZSfgX30TSuwG6gzWR6D+mK0dfVLMdQpW+6v80lrJr10/wZvOl2QTro2Pm++/W3SWnXkzy+OQR9
	wpqCtod/PWOz1k/VIYYL3YXV+EudOLw2gZpeg=
X-Received: by 2002:a05:622a:18a4:b0:50d:db76:55cd with SMTP id d75a77b69052e-516d43d9c7cmr188562681cf.52.1779701644983;
        Mon, 25 May 2026 02:34:04 -0700 (PDT)
X-Received: by 2002:a05:622a:18a4:b0:50d:db76:55cd with SMTP id d75a77b69052e-516d43d9c7cmr188562301cf.52.1779701644479;
        Mon, 25 May 2026 02:34:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395dcc2d61fsm21227531fa.33.2026.05.25.02.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 02:34:03 -0700 (PDT)
Date: Mon, 25 May 2026 12:34:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: Re: [PATCH 16/16] arm64: dts: qcom: shikra: enable WiFi on EVK boards
Message-ID: <qhm4zgn3yiahv6dfucisu7uwcxddty4fvl3wwx6gk2zm5ggzlr@n3nqcpkkwxps>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
 <20260525-shikra-dt-m1-v1-16-f51a9838dbaa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525-shikra-dt-m1-v1-16-f51a9838dbaa@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: qPWfXTdqo9KGzjXpXqU8YzIz09FnYUx6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA5NyBTYWx0ZWRfX+SEARwhYCI7X
 TZxBCTRacafOmz/ez9NlzHOeLZs+y55yb88JJS6mz69sSCTLhbgfVxCyKaK5gzmG3B2ZMJQYYjW
 ZbxvuxlsiPvAF92AKPYcAN26vWS8LRGjJWkjBsqriDO06hWpipBeGOtu8/U/ffK3MQCt3aN0WU6
 SAAJUZid7veHSWDBvKpx+v2tM4BRx87QXFNXWsR+BMbUeSoDaxaH5sj6DBeLH6JgEgKc5nKgULx
 5yj3cBMwu0zo7W6I9WbY6/+/n4S0dbXZWlOyICRtKCxU+ZqN/eJukhxkG+Glq3Tp7EOva1Tlqf9
 mtuPZ3L/LEB8Vj2UDl7ZIHQnYYdPyzNs5i4sg0ZC1q5FwQbxBrlxPkUBirB3sYOd3DtgmwB/KL8
 fd26SYsZgAy8TOTwO4vZKmXo4CrBtTqEkOmI4Ll99pl2nxEpE12srNY+JtcWJrGFph5UyEx+b9v
 vxDKrgkw7F0B6aGMoBw==
X-Authority-Analysis: v=2.4 cv=H7jrBeYi c=1 sm=1 tr=0 ts=6a14178e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=FEDGRNkftAy9gYbYj1YA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: qPWfXTdqo9KGzjXpXqU8YzIz09FnYUx6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250097
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10855-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 22BD25C8AE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 01:19:20AM +0530, Komal Bajaj wrote:
> From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> 
> Enable WiFi support on Shikra CQS, CQM and IQS EVK variants.
> 
> Provide board-specific WiFi configuration, including power supply
> connections and calibration variant selection. The WiFi node is
> enabled on each EVK according to the corresponding PMIC and board
> design.
> 
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 11 +++++++++++
>  arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 11 +++++++++++
>  arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 19 +++++++++++++++++++

It makes me wonder... You've added DSPs in three patches, one per board,
but BT and WiFi go together. Where is the logiic?

>  3 files changed, 41 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> index 259032bd20af..15208e1abff6 100644
> --- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> @@ -69,3 +69,14 @@ bluetooth {
>  		vddch0-supply = <&pm4125_l22>;
>  	};
>  };
> +
> +&wifi {
> +	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
> +	vdd-1.8-xo-supply = <&pm4125_l13>;
> +	vdd-1.3-rfa-supply = <&pm4125_l10>;
> +	vdd-3.3-ch0-supply = <&pm4125_l22>;

Squash with the BT changes. Use the PMU-based bindings. Don't forget the
swctrl GPIO.

> +	qcom,calibration-variant = "Shikra_EVK";

Was this submitted to ath10k-firmware?

> +	firmware-name = "cq2390";
> +
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
> index 142cc8da53ce..51267c1a86b3 100644
> --- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
> @@ -69,3 +69,14 @@ bluetooth {
>  		vddch0-supply = <&pm4125_l22>;
>  	};
>  };
> +
> +&wifi {
> +	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
> +	vdd-1.8-xo-supply = <&pm4125_l13>;
> +	vdd-1.3-rfa-supply = <&pm4125_l10>;
> +	vdd-3.3-ch0-supply = <&pm4125_l22>;
> +	qcom,calibration-variant = "Shikra_EVK";
> +	firmware-name = "cq2390";
> +
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
> index 9bf52030bcc5..f4e93cfb77e3 100644
> --- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
> @@ -30,6 +30,14 @@ vreg_bt_3p3_dummy: regulator-bt-3p3-dummy {
>  		regulator-max-microvolt = <3300000>;
>  		regulator-always-on;
>  	};
> +
> +	vreg_wlan_3p3_dummy: regulator-wlan-3p3-dummy {
> +		compatible = "regulator-fixed";
> +		regulator-name = "wlan_3p3_dummy";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;

Why is it dummy? Is there no regulator on the board?

> +	};
>  };
>  
>  &remoteproc_cdsp {
> @@ -77,3 +85,14 @@ bluetooth {
>  		vddch0-supply = <&vreg_bt_3p3_dummy>;
>  	};
>  };
> +
> +&wifi {
> +	vdd-0.8-cx-mx-supply = <&pm8150_s4>;
> +	vdd-1.8-xo-supply = <&pm8150_l12>;
> +	vdd-1.3-rfa-supply = <&pm8150_l8>;
> +	vdd-3.3-ch0-supply = <&vreg_wlan_3p3_dummy>;
> +	qcom,calibration-variant = "Shikra_EVK";
> +	firmware-name = "cq2390";
> +
> +	status = "okay";
> +};
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

