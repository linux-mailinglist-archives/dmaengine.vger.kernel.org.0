Return-Path: <dmaengine+bounces-644-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F1B81CF30
	for <lists+dmaengine@lfdr.de>; Fri, 22 Dec 2023 21:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC63286CB1
	for <lists+dmaengine@lfdr.de>; Fri, 22 Dec 2023 20:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FF82F844;
	Fri, 22 Dec 2023 20:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0neWqBr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05222F845;
	Fri, 22 Dec 2023 20:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e49a0b5caso2682757e87.0;
        Fri, 22 Dec 2023 12:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703276096; x=1703880896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FyqcGT2sN92VNs6tvDhaYPiQfK5r7CcXxTuhzZh5y8Q=;
        b=C0neWqBrtkq/gtGB6PkkEQN8sOUKlIhCMo035+kzmjH0Q3pXtLYIAxis15u1HfbMhY
         zl6z8RaVTbrwBGsqIGV5kAcr6AJfWwe8d0iYSk8nAy44oYLxOpn64K67nV/Nqlz4Cogf
         cCcVnxUT4UADSI626XMZjbr3RBBwujXwVuEvbnigFiuj76Tgx1+TLLBw8BByCmL5JMUR
         a28b7xHDJtBUF9L4YMgpn2hmnF2GfoRrFuvh5voZWkQoJ6N03P8ObF8Gep2o4vaNHIxt
         3DxnMbojq/0eVmENWuvG83RynCCJZ3nXknV7czHBx2SwAxJrhctWGZ1v095hrzAgPd0K
         zNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703276096; x=1703880896;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FyqcGT2sN92VNs6tvDhaYPiQfK5r7CcXxTuhzZh5y8Q=;
        b=ufduEkTT+I6rHF8+B0amVaTPRSXMrz2DvGR2Y2xfZU1fAsXz35YhBnuoPKCqeBgm0Y
         VUEwahHxV2i0qt/dsCTNlCfAPvzAXByzyl37Fx57QxbY/1AlgCJVlgGlAg+/5RYuO6io
         IYHtzKT4Mj9CQHm/l6oA+BzNKMY0LFMn01lvi0RY82wbH4X6QBYosf9cfi/it/XVdV82
         DpZF3ovhn2e1H4lBk0KNiwBRR+yv413XI9TiNPOVT6xIPAJt5mD9WLI5AWhxw37uCin5
         rOemKf/iP6jw/qikQjuN09mjVTf8x8f1dl4uczSNf32tYeRJmz51FEqXfxmerkHaQQk2
         AL/w==
X-Gm-Message-State: AOJu0Yz1lAlvyfVFVvFvB1NlR2wIwfGFqAnJpvkXMFxNnwu7fddFYfx4
	dX6BN768OUHb1dCrnUhC6ec=
X-Google-Smtp-Source: AGHT+IHWpBsM8wbop48hkzWW0SiXiXe3BoSZQM0QW/88GBDtenoNLaCXath99TrZaJbMHdcqiMIUMA==
X-Received: by 2002:ac2:4c8c:0:b0:50e:386a:eedb with SMTP id d12-20020ac24c8c000000b0050e386aeedbmr769089lfl.70.1703276095452;
        Fri, 22 Dec 2023 12:14:55 -0800 (PST)
Received: from [10.0.0.42] (host-213-145-197-219.kaisa-laajakaista.fi. [213.145.197.219])
        by smtp.gmail.com with ESMTPSA id h22-20020ac24db6000000b0050e7152daffsm48798lfe.182.2023.12.22.12.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Dec 2023 12:14:54 -0800 (PST)
Message-ID: <4b5bd2c2-37c9-4cdf-934d-8bc6d6f73152@gmail.com>
Date: Fri, 22 Dec 2023 22:16:11 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Add APIs to request TX/RX DMA channels for thread
 ID
To: Siddharth Vadapalli <s-vadapalli@ti.com>, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, vigneshr@ti.com
References: <20231218062640.2338453-1-s-vadapalli@ti.com>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20231218062640.2338453-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Siddharth,

On 12/18/23 08:26, Siddharth Vadapalli wrote:
> The existing APIs for requesting TX and RX DMA channels rely on parsing
> a device-tree node to obtain the Channel/Thread IDs from their names.
> However, it is possible to know the thread IDs by alternative means such
> as being informed by Firmware on a remote core via RPMsg regarding the
> allocated TX/RX DMA channel thread IDs. In such cases, the driver can be
> probed by non device-tree methods such as RPMsg-bus, due to which it is not
> necessary that the device using the DMA has a device-tree node
> corresponding to it. Thus, add APIs to enable the driver to make use of
> the existing DMA APIs even when there's no device-tree node.
> 
> Additionally, since the name of the device for the remote RX channel is
> being set purely on the basis of the RX channel ID itself, it can result
> in duplicate names when multiple flows are used on the same channel.
> Avoid name duplication by including the flow in the name.

Thank you for the updates,
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> Series is based on linux-next tagged next-20231215.
> 
> v2:
> https://lore.kernel.org/r/20231212111011.1401641-1-s-vadapalli@ti.com/
> Changes since v2:
> - Rebased series on linux-next tagged next-20231215.
> - Renamed the function "k3_udma_glue_request_tx_chn_by_id()" to
>   "k3_udma_glue_request_tx_chn_for_thread_id()" as suggested by:
>   Péter Ujfalusi <peter.ujfalusi@gmail.com>
> - Similar to the above change, I have also renamed the function
>   "k3_udma_glue_request_remote_rx_chn_by_id()" to
>   "k3_udma_glue_request_remote_rx_chn_for_thread_id()".
> - Updated the function prototypes in include/linux/dma/k3-udma-glue.h
>   accordingly.
> - Updated the commit messages for patches 3/4 and 4/4 to match the
>   changes made to the function names.
> 
> v1:
> https://lore.kernel.org/r/20231114083906.3143548-1-s-vadapalli@ti.com/
> Changes since v1:
> - Rebased series on linux-next tagged next-20231212.
> - Updated commit messages with details regarding the use-case for which
>   the newly added APIs will be required.
> - Removed unnecessary return value check within
>   "of_k3_udma_glue_parse_chn()" function in patch 1, since it will fall
>   through to "out_put_spec" anyway.
> - Removed unnecessary return value check within
>   "of_k3_udma_glue_parse_chn_by_id()" function in patch 1, since it will
>   fall through to "out_put_spec" anyway.
> - Moved patch 4 of v1 series to patch 2 of current series.
> 
> RFC Series:
> https://lore.kernel.org/r/20231111121555.2656760-1-s-vadapalli@ti.com/
> Changes since RFC Series:
> - Rebased patches 1, 2 and 3 on linux-next tagged next-20231114.
> - Added patch 4 to the series.
> 
> Regards,
> Siddharth.
> 
> Siddharth Vadapalli (4):
>   dmaengine: ti: k3-udma-glue: Add function to parse channel by ID
>   dmaengine: ti: k3-udma-glue: Update name for remote RX channel device
>   dmaengine: ti: k3-udma-glue: Add function to request TX chan for
>     thread ID
>   dmaengine: ti: k3-udma-glue: Add function to request RX chan for
>     thread ID
> 
>  drivers/dma/ti/k3-udma-glue.c    | 306 ++++++++++++++++++++++---------
>  include/linux/dma/k3-udma-glue.h |  10 +
>  2 files changed, 229 insertions(+), 87 deletions(-)
> 

-- 
Péter

