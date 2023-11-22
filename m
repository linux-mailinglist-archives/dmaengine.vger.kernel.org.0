Return-Path: <dmaengine+bounces-173-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8533C7F4A23
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 16:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 158A3B20AF9
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 15:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD5E4D59B;
	Wed, 22 Nov 2023 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBiwfeEt"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C744492;
	Wed, 22 Nov 2023 07:21:23 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507cee17b00so8989635e87.2;
        Wed, 22 Nov 2023 07:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700666482; x=1701271282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oZb7t9CIaCI1EmqCGNDEmmfTHYSkAh2W2qnzin89dzA=;
        b=XBiwfeEtRMv6mDKRa9lGJeiewy6sfr7YweV8W5K7LEUI7dIIFb+aTdaAmVejqFXSL+
         b1/2fZYWgNB0jm1sKWKGRiAGwezEKyj+FhHZGoIvlX/ulbWmHQUNRp8InCG3Ys0+cGWC
         KpKqf8PeKOI1o13it5RJv8mBKfep+YmOVItaOnFbHhx6FLHTRD/03QoxaNiJl9NyDbcn
         H+4uuR2e00aoucaoGxb2mcRArWDqaOGHqayOIFQ2DGQydXRNwPfADykvk+pEBlF8/htR
         i2PfPlbxqTru0yLAG6KCO34I73t8cnkeJ1hwS+heCnVDbWdMHuWC4RUi+h+NDJV8VORt
         OHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700666482; x=1701271282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oZb7t9CIaCI1EmqCGNDEmmfTHYSkAh2W2qnzin89dzA=;
        b=m7E/PL8HgVJ8QzO5K5G34dEpWwtpWgk+tuQbdcjWOmSY46oAJbvOb7aEYbVIQwbQDv
         66PzpgvPtq3O6jo8w8y2870MGo9j0WfW+LKTn6zT4y5MwWI6AXlN28pOG3Qu0UYp0+w2
         1ELzZ1h5ljLhvXmSaCQHvEgn6YqsUV3ZbaxrZGXjXZ63xpoEhCm1YmCl+VZUgNj0Z+S9
         3taC1vCqlinJJnLtAXJcImpDp//mDv52XY9k/C4vTWyPc1sURTdPh/+mK7vN8Y+9LzZ4
         QDOSzUi9ASkLiUyegS0rX2LwZ0psHymrvrvNwNrw7SWAxPLPOziwIUozXEGteOULV3O1
         40bg==
X-Gm-Message-State: AOJu0YzocM41oCUutDFBq/Vj/7+v+YEeLDh7pBo/oo0cv8tMYy0UHbYs
	XaYl7J8fqrFBw0O4RnUZdIQ=
X-Google-Smtp-Source: AGHT+IERwepuirZh9+8AanLFanzyVFkQXgU0ThpU6hGLzGEZcIO0CGc5ahO2OuSVGVtes+ubfWEzQw==
X-Received: by 2002:a19:5506:0:b0:500:7cab:efc3 with SMTP id n6-20020a195506000000b005007cabefc3mr1958214lfe.11.1700666481663;
        Wed, 22 Nov 2023 07:21:21 -0800 (PST)
Received: from ?IPV6:2001:999:251:b686:cec4:d552:2937:637c? ([2001:999:251:b686:cec4:d552:2937:637c])
        by smtp.gmail.com with ESMTPSA id m16-20020a0565120a9000b0050aa9e8e26asm1317351lfu.5.2023.11.22.07.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 07:21:20 -0800 (PST)
Message-ID: <ed1d0221-d0ee-4a7d-8955-d5973027d113@gmail.com>
Date: Wed, 22 Nov 2023 17:22:47 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add APIs to request TX/RX DMA channels by ID
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 srk@ti.com, vigneshr@ti.com
References: <20231114083906.3143548-1-s-vadapalli@ti.com>
 <9d465de4-3930-4856-9d8e-7deb567a628f@gmail.com>
 <c693efec-ab67-44bb-8871-a40dc408f278@ti.com>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <c693efec-ab67-44bb-8871-a40dc408f278@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Siddharth,

On 17/11/2023 07:55, Siddharth Vadapalli wrote:
>> I would really like to follow a standard binding since what will happen
>> if the firmware will start to provision channels/flows for DMAengine
>> users? It is not that simple to hack that around.
> 
> Please consider the following use-case for which the APIs are being added by
> this series. I apologize for not explaining the idea behind the APIs in more
> detail earlier.
> 
> Firmware running on a remote core is in control of a peripheral (CPSW Ethernet
> Switch for example) and shares the peripheral across software running on
> different cores. The control path between the Firmware and the Clients on
> various cores is via RPMsg, while the data path used by the Clients is the DMA
> Channels. In the example where Clients send data to the shared peripheral over
> DMA, the Clients send RPMsg based requests to the Firmware to obtain the
> allocated thead IDs. Firmware allocates the thread IDs by making a request to
> TISCI Resource Manager followed by sharing the thread IDs to the Clients.
> 
> In such use cases, the Linux Client is probed by RPMsg endpoint discovery over
> the RPMsg bus. Therefore, there is no device-tree corresponding to the Client
> device. The Client knows the DMA Channel IDs as well as the RX Flow details from
> the Firmware. Knowing these details, the Client can request the configuration of
> the TX and RX Channels/Flows by using the DMA APIs which this series adds.

I see, so the CPSW will be probed in a similar way as USB peripherals
for example? The CPSW does not have a DT entry at all? Is this correct?

> Please let me know in case of any suggestions for an implementation which shall
> address the above use-case.

How does the driver knows how to request a DMA resource from the remote
core? How that scales with different SoCs and even with changes in the
firmware?

You are right, this is in a grey area. The DMA channel as it is
controlled by the remote processor, it lends a thread to clients on
other cores (like Linux) via RPMsg.
Well, it is similar to how non DT is working in a way.

This CPSW type is not yet supported mainline, right?

-- 
Péter

