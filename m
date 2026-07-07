Return-Path: <dmaengine+bounces-12065-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hoVKKHbTTGqMqQEAu9opvQ
	(envelope-from <dmaengine+bounces-12065-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 12:22:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBAC71A48C
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 12:22:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=MQuNfbbv;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=YZpExohT;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12065-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12065-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 115EE313833F
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2026 10:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5093DCD98;
	Tue,  7 Jul 2026 10:15:34 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657B53DD87E
	for <dmaengine@vger.kernel.org>; Tue,  7 Jul 2026 10:15:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419334; cv=none; b=idOqEX7cyMjzqBTy6hGd8Lz7Sjlr4tFJDbt26V+U/8WxnDewL8FAlIkw/RugNY9eFeabPh/0Wfs/7/o4EeiiqZqJzrndFNlPHBDUkRuhXZk8H5PnhjoG8j1CFlMHsp6WhpJ9yxOFlFr4ZbjUMRsIMTf0eL0WURWpSuNHLL8zIW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419334; c=relaxed/simple;
	bh=1tk/upgsaJYwS65PF3VTqYUqof/+pSIPwJVVIVSs9aU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J4z7yenFwaD0UGT2WKWlxMRz9Bprk8a8rbyOtehukWv4x5EYX9HwuflRkrQWJMeNdXm2se3UoJo8sT51UXGLP1hMJWnkK+6gA/I31ipL/nPrhRn1gSWPA8Zq2lItrhssdPIe4k9EC5/6QJ7TmL/k/GOODZO66ZsjXMSfTs4rQbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MQuNfbbv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YZpExohT; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6678EB5G3231398
	for <dmaengine@vger.kernel.org>; Tue, 7 Jul 2026 10:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	utLvZziuSambl+y9XEr31wpRmXka6gzmw01V+qISh20=; b=MQuNfbbvH78fheWc
	eqljI8a4vB5wRUoAfBkJ1MW+71SZX0C9TWThBR2UkHx3m7cWPSxK/rrrJkQwT+vq
	D33ZSciUg1ZN9T8A4oEU6+FCKUaChCS3Kk9AkCU+pBiy7AGWhou4K5U2kdrd1+XU
	w7ctxcqyOcHbwWGc8h8ghU2e6tjagG2cr+DpfuxpZJNhtatL5wSHu3JYBVmSSwmt
	Xj/N+7rnJ+McgBbw/SIKMtut+VPIT6SsyC/sRAde2C7feVrtxvixrg/1alLaPREG
	cqz6m3FUl27vYgrgsjVUUCppkLnsxmDKimoXNq99XefYOd8gdqnggxLCTpPRr7Wx
	XvOQTA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8qj79wqu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 07 Jul 2026 10:15:31 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-845bc2e658aso3737538b3a.3
        for <dmaengine@vger.kernel.org>; Tue, 07 Jul 2026 03:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783419331; x=1784024131; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=utLvZziuSambl+y9XEr31wpRmXka6gzmw01V+qISh20=;
        b=YZpExohTArM7JlGoo3/6Pzf7NZ6j0F3oLGsNwBgN296zHEZykhi2pEkAU5qb6Ju1Wl
         uAsUf7qHn5kMEJUjpxqLNw5ZxeR8W83ubJUFFiQwqaQDfPBjOreWyb1CX6gaJhG5dNb6
         RSIWxJAKWgNLz0XDdK036pFNwawOsSw+kJxhd6l8lkXmDVxNt4S8X+2PVoc3F3WvZOP+
         m1h+MwArzBlxO0ThPiknulA+0LE7ceyV5OwtejelkCg3s462v27WlS1TrJGVVcBwC8cO
         4ttWY78HNJ1QBKAUo/d06og0wWbUoi5cxz1/DzHXKPD2007QX54Iu8QLOgmZlxdrK6Bl
         3InQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783419331; x=1784024131;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=utLvZziuSambl+y9XEr31wpRmXka6gzmw01V+qISh20=;
        b=ASFDgIJ61xHI7IWj8CEqWbIiJMqTGXfbakb0CaE6rJXPSgqa6PnK/a4feD5e0A3sYo
         2FmXoZzxxsz+LsDZQm4L5HFoiIiH8f30t3Mn+VKwV4nXYAEwTCq/85+Mudv5zHY/hcno
         1Ti7yZBj8iKoLstCPopmQ6nV4sypvxYPkkKRUPP6uM9BWDebSDqSMKXb8HpI+MIc27S1
         4vgxH8UayX0ffUWCv2fynYiFC6cXJnQuglKTSa4PwZE3z1oGTtI9LWERC15qCAzwXwod
         VIomUqa8+gvU6sluIx9Ciz5HK01nbaeA89MC4K6YoT6B8SFb2IeqU0qHuTFV7pYYeMtQ
         r7Mg==
X-Forwarded-Encrypted: i=1; AHgh+RoGcTwTAQLW5/F25fvck951FWIhgQOwajAo2+0piXPAwle04h5GYm9+lwurtHICcXWJPVjegJU034Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKxY1sOG8XxDJHnFuymskxDp4FoGqTX8ZuJ9L2c03XmfX1oolB
	f6MvFB0tNpba5SkoB3CVoxh8lKjlbgt+tjB64FSue++M8A8ZFpFHK/LPR7YB5NJi8e61k/DOvbk
	H6opvcbBgjoWEUdm+2Da27pzc0xs/Cjs/6yxXUPy+eOV1WscLcyYCj7AFOEfT3Cg=
X-Gm-Gg: AfdE7cmX1CKqHWJ5dYY0f7PncL0iHboXyQY8yom0Bhmk8v5H+tuATNydZABEvSFccNj
	E4SsedlK/Msb4M89bCmyKvBJRc1bQQ3Jz1lW0Bs7rDyy5PJ3KKOhKHVn88DYO12yFFo4njALxmo
	zpYqVtqF+caZ2G3+D5ycekl0w3ClR2Lk5c3VwKMJX/0oGvvIlKLgdtbonpWAudP7inOFh1kOpfT
	za4eEiSRiG4iGclZ+Vmg2A4tRTWgfKKAk5P7nUhBH7VjJcq1bhvNGZpFHjr476AqhaLcPlVsD8n
	7S/6dSDrL7tuRq+bviUC/8EfAVtJ6YiaS13r9kxL/+9sGFdmjsOjr6/IS6c7jvHlitvEYrWdC2+
	+hCp9J6w52Tej61wVWzTNX896xG5atAqOuzqTlhTTDDGP
X-Received: by 2002:a05:6a00:6f42:b0:848:2c2e:c79e with SMTP id d2e1a72fcca58-8482c2ec98emr2384929b3a.12.1783419330975;
        Tue, 07 Jul 2026 03:15:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:6f42:b0:848:2c2e:c79e with SMTP id d2e1a72fcca58-8482c2ec98emr2384900b3a.12.1783419330317;
        Tue, 07 Jul 2026 03:15:30 -0700 (PDT)
Received: from [10.92.162.241] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d76e0esm5100983b3a.41.2026.07.07.03.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 03:15:29 -0700 (PDT)
Message-ID: <517839de-767a-4f35-a130-ad008eda2886@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 15:45:27 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: Defer IRQ trigger type to
 device tree
To: sashiko-reviews@lists.linux.dev
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
References: <20260611-qcom-bam-dma-irq-trigger-v1-1-21c216e00b2a@oss.qualcomm.com>
 <20260611062838.CE8D01F00893@smtp.kernel.org>
Content-Language: en-US
From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
In-Reply-To: <20260611062838.CE8D01F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: IjraPk8gxLoN_jIUsb7AuSDSsY-pkhOG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA5OSBTYWx0ZWRfX866G+SmUqVWO
 2BXRwIYUfMCmMFUXFwo8SUTsnkDwSVmi7fMQxQ1rBUksfrdakbWOv/4FeRKsrSD8i8HKlpc7GEN
 6FlUt2JM61PLYF3S8Iw+3ALVPv3MrV1Iz4JW2w1wHdLMufhr6E+yaIc9CohLpKKt9/raw86+5oH
 D4WiFXENuJAulXgEVbZ7TOhpZ89ktHG2n0yciYHr8Ain27Qh7MRFd9DifOTMf9tj8P7+lOsrVD6
 AD1L0kvkNrb5KMht1Il8r8KWkyLxmX7OIq0FSPwP+jr8jcxlxnpLoYWw+pyxIDnvsIHelz9MuTW
 pfAqpxMl5Vbu68ifcllk9gkZ9tWu5I4AsEfLfSSF9FmQbWcU7ktLbpiUISUvUZc9PK/qiqKsVQz
 +SoIEpP8oiI8xMo5xU4d2YdQptAb4nSziAnMQa1xsdIGw6Fc1H3yRiKTTa/VXpcbxYwjZtU40me
 MlC4ZICy7lJfSdrhqXg==
X-Authority-Analysis: v=2.4 cv=PIM/P/qC c=1 sm=1 tr=0 ts=6a4cd1c3 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=j-lP-nYXe62oYfzXaHYA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA5OSBTYWx0ZWRfXz/mRtOM5lKXe
 LxgG+ileJlzb7LLP0RpUvoqJAoQwgeHDdfZz81/XkYCF0an6MHgeFuRC2fjkgniMbcz+02WTY62
 Cu/5wPaUwR+enn4MLwaelrr4yAqvhco=
X-Proofpoint-GUID: IjraPk8gxLoN_jIUsb7AuSDSsY-pkhOG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070099
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12065-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[vishnu.santhosh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishnu.santhosh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ECBAC71A48C


On 11-06-2026 11:58 am, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential issue(s) to consider:
>
> New issues:
> - [High] Allowing edge-triggered interrupts without a polling loop in the handler introduces a race condition that permanently deadlocks the DMA controller.
>
> Pre-existing issues:
> - [High] bam_dma_remove accesses hardware registers after forcing PM runtime suspend, leading to unclocked register accesses and system crash.
> - [High] The probe error path cleans up tasklets and disables clocks before freeing the interrupt, leading to a use-after-free and unclocked access race condition.
> - [High] The interrupt is requested before PM runtime is fully enabled, causing a permanent interrupt storm if an interrupt fires during probe.
> - [High] Failure paths after `pm_runtime_get_sync()` return without decrementing the PM usage counter, causing an unbalanced usage count and leaking DMA resources.
> - [High] The interrupt handler unconditionally returns IRQ_HANDLED even for spurious interrupts, defeating the kernel's spurious interrupt detection.
> --
>
> commit ee883954f4570a653a82ea860b70acc6baa4eada
> Author: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
> Date:   Thu Jun 11 06:17:11 2026 +0000
>
> dmaengine: qcom: bam_dma: Defer IRQ trigger type to device tree
>
> This commit changes the hardcoded IRQF_TRIGGER_HIGH flag to
> IRQF_TRIGGER_NONE when registering the BAM interrupt. This delegates the
> trigger type configuration to the device tree, resolving missed DMA
> completions on platforms that use edge-triggered interrupts.
>
>> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
>> index 19116295f8325..6c3e2ca8a572f 100644
>> --- a/drivers/dma/qcom/bam_dma.c
>> +++ b/drivers/dma/qcom/bam_dma.c
>> @@ -1303,7 +1303,7 @@ static int bam_dma_probe(struct platform_device *pdev)
>>   		bam_channel_init(bdev, &bdev->channels[i], i);
>>   
>>   	ret = devm_request_irq(bdev->dev, bdev->irq, bam_dma_irq,
>> -			IRQF_TRIGGER_HIGH, "bam_dma", bdev);
>> +			IRQF_TRIGGER_NONE, "bam_dma", bdev);
> [Severity: High]
> This delegates the trigger type to the device tree and allows edge-triggered
> interrupts.
>
> Does this regression introduce a potential deadlock if the hardware asserts
> a new completion before the previous interrupt is cleared?
>
> If bam_dma_irq() only reads the BAM status registers once per invocation,
> and a new completion arrives after the status register is read, the
> overall interrupt line might remain asserted.
>
> Because there is no new edge, the interrupt controller would never fire
> again.
>
> Should we add a loop to drain all pending events until the status register
> reads zero?

The patch does not force edge-triggered interrupts; it changes
IRQF_TRIGGER_HIGH to IRQF_TRIGGER_NONE so that the trigger type is taken
from the device tree and stops the driver from silently overriding that
configuration.

The edge-triggered race condition is out of scope of this change.

>
> [Severity: High]
> This is a pre-existing issue, but requesting the IRQ here before
> pm_runtime_enable() and pm_runtime_set_active() completes might cause an
> interrupt storm.
>
> If an early interrupt fires while the device's PM runtime status is still
> suspended:
>
> drivers/dma/qcom/bam_dma.c:bam_dma_irq() {
>      ...
>      ret = pm_runtime_get_sync(bdev->dev);
>      if (ret < 0)
>          return IRQ_NONE;
>      ...
> }
>
> Will pm_runtime_get_sync() fail and return IRQ_NONE without clearing the
> hardware interrupt, keeping the interrupt line asserted permanently?

All flagged issues are pre-existing and not introduced or worsened by this
patch. Bundling their fixes here would obscure the purpose of both changes
and complicate bisection.

>>   	if (ret)
>>   		goto err_bam_channel_exit;
> [Severity: High]
> This is a pre-existing issue, but does this error path create a
> use-after-free and unclocked access race condition?
>
> If a failure occurs later in probe, the error path manually kills tasklets
> and disables the clock:
>
> drivers/dma/qcom/bam_dma.c:bam_dma_probe() {
>      ...
> err_bam_channel_exit:
>      for (i = 0; i < bdev->num_channels; i++)
>          tasklet_kill(&bdev->channels[i].vc.task);
> err_tasklet_kill:
>      tasklet_kill(&bdev->task);
> err_disable_clk:
>      clk_disable_unprepare(bdev->bamclk);
>
>      return ret;
> }
>
> Since devm_request_irq() was used, the interrupt remains active until devres
> cleanup.
>
> If an interrupt fires in this window, will bam_dma_irq() access unclocked
> BAM registers and schedule a killed tasklet?
>
> [ ... ]
>
> [Severity: High]
> This is a pre-existing issue, but does bam_dma_remove() access hardware
> registers after they have been unclocked?
>
> During driver unbinding, pm_runtime_force_suspend() disables the BAM clock.
>
> Immediately after, the code writes to the registers:
>
> drivers/dma/qcom/bam_dma.c:bam_dma_remove() {
>      ...
>      pm_runtime_force_suspend(&pdev->dev);
>
>      of_dma_controller_free(pdev->dev.of_node);
>      dma_async_device_unregister(&bdev->common);
>
>      /* mask all interrupts for this execution environment */
>      writel_relaxed(0, bam_addr(bdev, 0,  BAM_IRQ_SRCS_MSK_EE));
>      ...
> }
>
> Will accessing these unclocked peripheral registers generate an asynchronous
> bus fault and crash the system?
>
> [Severity: High]
> This is a pre-existing issue, but does bam_free_chan() leak the PM usage
> counter and DMA resources on failure?
>
> When pm_runtime_get_sync() returns an error, it still increments the PM
> usage counter.
>
> The failure path returns immediately:
>
> drivers/dma/qcom/bam_dma.c:bam_free_chan() {
>      ...
>      ret = pm_runtime_get_sync(bdev->dev);
>      if (ret < 0)
>          return;
>
>      vchan_free_chan_resources(to_virt_chan(chan));
>      ...
> }
>
> Does returning here without calling pm_runtime_put_noidle() permanently
> prevent the device from suspending, and skip freeing the channel resources
> leading to a memory leak?
>
> [Severity: High]
> This is a pre-existing issue, but does bam_dma_irq() incorrectly return
> IRQ_HANDLED for spurious interrupts?
>
> If no channel interrupts are found and the global BAM interrupt is not set,
> the handler falls through:
>
> drivers/dma/qcom/bam_dma.c:bam_dma_irq() {
>      ...
>      pm_runtime_mark_last_busy(bdev->dev);
>      pm_runtime_put_autosuspend(bdev->dev);
>
>      return IRQ_HANDLED;
> }
>
> Does this unconditionally return IRQ_HANDLED even for spurious interrupts,
> defeating the kernel's spurious interrupt detection and potentially causing
> an infinite interrupt loop?
>

