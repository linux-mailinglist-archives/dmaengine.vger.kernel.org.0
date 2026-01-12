Return-Path: <dmaengine+bounces-8217-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D8AD13C0B
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jan 2026 16:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13CE830071B8
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jan 2026 15:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360F534252C;
	Mon, 12 Jan 2026 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fOrfBrGB"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185FB3112C4;
	Mon, 12 Jan 2026 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232616; cv=none; b=Fq/SR9tNIkz0sIIAdl8sxj6qelhGMWjzLstiuvlH40A1cYOcJiWijH8q+wdAEJPgBXAI2w8PUPL3sZMOkkbsM1GmhV7h3ORYi1zi3Jkr7RFjrANJGZvp5WTJPe3RfiAt/fu88IyQQiNnMaHqeU807LAKklJeat9IwAWLsxHYdNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232616; c=relaxed/simple;
	bh=ttyw+Z9A6Ugb9XsJhcYqjED5RJ4KVzUON4Nc9GQdA8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvtwjW3AygSVSgPmcgl6MiG4stlDKbJi8jmml55zB1nt34pvbRm6TPj3VvTnR4nZHmC0z91jfQH699SS3zvoLkpZYiUWR+BHRMgEFCrhYv+E60vcSlAmPPbk1E134SkvlpSddrGSfms02qt5uG3m07n0BHsDb8ZqQnpbtc2pUGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fOrfBrGB; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768232614; x=1799768614;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ttyw+Z9A6Ugb9XsJhcYqjED5RJ4KVzUON4Nc9GQdA8c=;
  b=fOrfBrGBnCvHkekiwLYqSX1hRHiXbaG9jKy21e4HeSEz1icuxKRvunVA
   hr59EpC9jmKdyUVDea+xHudWyHlZzeGtVRVL+NXldOdu5Ttzve6fM3izx
   gLyKfrkyHHPvEBfmfxDN34N/pPuNAx3W4TWn+rz3CE13mv9J4KJO6yZ6O
   OvrxNCK02TvXnHr3dhUOdhHq6+khLQNwYXLsOBBkboOlTeiPcw7pLzn+T
   JnkkJmXX5Zxkgt2++uDWMlLlp9fzVhWXDCzhHA4WHFEgPSZiF0CY3+0BY
   T11u+lmtecoy8iZLpHIIJU5VlMgfg6YqOeVsDTcxKFGwmQtaDTmWGX4+4
   A==;
X-CSE-ConnectionGUID: BOI4/mB6QSy1YXarsqmJXA==
X-CSE-MsgGUID: +LoLcujERyCrSaPVumaIXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="69664113"
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="69664113"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 07:43:33 -0800
X-CSE-ConnectionGUID: mYxfRhNcTuC89TqzwR8OuA==
X-CSE-MsgGUID: 6cZwTC1iS0eMNNfq0rXzWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="204029064"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.110.139]) ([10.125.110.139])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 07:43:29 -0800
Message-ID: <71518468-e877-4b78-ac22-bb50e40915f3@intel.com>
Date: Mon, 12 Jan 2026 08:43:28 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 26/35] NTB: ntb_transport: Introduce DW eDMA backed
 transport mode
To: Koichiro Den <den@valinux.co.jp>
Cc: Frank.Li@nxp.com, ntb@lists.linux.dev, linux-pci@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mani@kernel.org,
 kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
 corbet@lwn.net, geert+renesas@glider.be, magnus.damm@gmail.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, jdmason@kudzu.us,
 allenbh@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
 kurt.schwemmer@microsemi.com, logang@deltatee.com, jingoohan1@gmail.com,
 lpieralisi@kernel.org, utkarsh02t@gmail.com, jbrunet@baylibre.com,
 dlemoal@kernel.org, arnd@arndb.de, elfring@users.sourceforge.net
References: <20251217151609.3162665-1-den@valinux.co.jp>
 <20251217151609.3162665-27-den@valinux.co.jp>
 <e3229f31-e781-4680-aed1-05ad5174a793@intel.com>
 <gvwki3y5bec5lr4eukzreuojw4t55og72bnuoh74gmbgrdbtiq@c5qgmt5cdygd>
 <cb83f12f-14f9-4df1-bd43-c127a06bb7dc@intel.com>
 <rlqffb3dnvalfjj4vcbmqkraqxmqdv5vd4tpqq2cssyuwrydc3@ujkesovxdgfy>
 <71fd5c95-3734-479f-b1dd-9a2b48fdeb74@intel.com>
 <3zrstpea6x4imus6vskkm72hnf45l32qai4d6qdtyf5fu7tzl6@nl2xlv7ivka7>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <3zrstpea6x4imus6vskkm72hnf45l32qai4d6qdtyf5fu7tzl6@nl2xlv7ivka7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/10/26 6:43 AM, Koichiro Den wrote:
> On Thu, Jan 08, 2026 at 10:55:46AM -0700, Dave Jiang wrote:
>>
>>
>> On 1/7/26 6:25 PM, Koichiro Den wrote:
>>> On Wed, Jan 07, 2026 at 12:02:15PM -0700, Dave Jiang wrote:
>>>>
>>>>
>>>> On 1/7/26 7:54 AM, Koichiro Den wrote:
>>>>> On Tue, Jan 06, 2026 at 11:51:03AM -0700, Dave Jiang wrote:
>>>>>>
>>>>>>
>>>>>> On 12/17/25 8:16 AM, Koichiro Den wrote:
>>>>>>> Add a new ntb_transport backend that uses a DesignWare eDMA engine
>>>>>>> located on the endpoint, to be driven by both host and endpoint.
>>>>>>>
>>>>>>> The endpoint exposes a dedicated memory window which contains the eDMA
>>>>>>> register block, a small control structure (struct ntb_edma_info) and
>>>>>>> per-channel linked-list (LL) rings for read channels. Endpoint drives
>>>>>>> its local eDMA write channels for its transmission, while host side
>>>>>>> uses the remote eDMA read channels for its transmission.
>>>>>>>
>>>>>>> A key benefit of this backend is that the memory window no longer needs
>>>>>>> to carry data-plane payload. This makes the design less sensitive to
>>>>>>> limited memory window space and allows scaling to multiple queue pairs.
>>>>>>> The memory window layout is specific to the eDMA-backed backend, so
>>>>>>> there is no automatic fallback to the memcpy-based default transport
>>>>>>> that requires the different layout.
>>>>>>>
>>>>>>> Signed-off-by: Koichiro Den <den@valinux.co.jp>
>>>>>>> ---
>>>>>>>  drivers/ntb/Kconfig                  |  12 +
>>>>>>>  drivers/ntb/Makefile                 |   2 +
>>>>>>>  drivers/ntb/ntb_transport_core.c     |  15 +-
>>>>>>>  drivers/ntb/ntb_transport_edma.c     | 987 +++++++++++++++++++++++++++
>>>>>>>  drivers/ntb/ntb_transport_internal.h |  15 +
>>>>>>>  5 files changed, 1029 insertions(+), 2 deletions(-)
>>>>>>>  create mode 100644 drivers/ntb/ntb_transport_edma.c
>>>>>>>
>>>>>>> diff --git a/drivers/ntb/Kconfig b/drivers/ntb/Kconfig
>>>>>>> index df16c755b4da..5ba6d0b7f5ba 100644
>>>>>>> --- a/drivers/ntb/Kconfig
>>>>>>> +++ b/drivers/ntb/Kconfig
>>>>>>> @@ -37,4 +37,16 @@ config NTB_TRANSPORT
>>>>>>>  
>>>>>>>  	 If unsure, say N.
>>>>>>>  
>>>>>>> +config NTB_TRANSPORT_EDMA
>>>>>>> +	bool "NTB Transport backed by remote eDMA"
>>>>>>> +	depends on NTB_TRANSPORT
>>>>>>> +	depends on PCI
>>>>>>> +	select DMA_ENGINE
>>>>>>> +	select NTB_EDMA
>>>>>>> +	help
>>>>>>> +	  Enable a transport backend that uses a remote DesignWare eDMA engine
>>>>>>> +	  exposed through a dedicated NTB memory window. The host uses the
>>>>>>> +	  endpoint's eDMA engine to move data in both directions.
>>>>>>> +	  Say Y here if you intend to use the 'use_remote_edma' module parameter.
>>>>>>> +
>>>>>>>  endif # NTB
>>>>>>> diff --git a/drivers/ntb/Makefile b/drivers/ntb/Makefile
>>>>>>> index 9b66e5fafbc0..b9086b32ecde 100644
>>>>>>> --- a/drivers/ntb/Makefile
>>>>>>> +++ b/drivers/ntb/Makefile
>>>>>>> @@ -6,3 +6,5 @@ ntb-y			:= core.o
>>>>>>>  ntb-$(CONFIG_NTB_MSI)	+= msi.o
>>>>>>>  
>>>>>>>  ntb_transport-y		:= ntb_transport_core.o
>>>>>>> +ntb_transport-$(CONFIG_NTB_TRANSPORT_EDMA)	+= ntb_transport_edma.o
>>>>>>> +ntb_transport-$(CONFIG_NTB_TRANSPORT_EDMA)	+= hw/edma/ntb_hw_edma.o
>>>>>>> diff --git a/drivers/ntb/ntb_transport_core.c b/drivers/ntb/ntb_transport_core.c
>>>>>>> index 40c2548f5930..bd21232f26fe 100644
>>>>>>> --- a/drivers/ntb/ntb_transport_core.c
>>>>>>> +++ b/drivers/ntb/ntb_transport_core.c
>>>>>>> @@ -104,6 +104,12 @@ module_param(use_msi, bool, 0644);
>>>>>>>  MODULE_PARM_DESC(use_msi, "Use MSI interrupts instead of doorbells");
>>>>>>>  #endif
>>>>>>>  
>>>>>>> +bool use_remote_edma;
>>>>>>> +#ifdef CONFIG_NTB_TRANSPORT_EDMA
>>>>>>> +module_param(use_remote_edma, bool, 0644);
>>>>>>> +MODULE_PARM_DESC(use_remote_edma, "Use remote eDMA mode (when enabled, use_msi is ignored)");
>>>>>>> +#endif
>>>>>>
>>>>>> This seems clunky. Can the ntb_transport_core determine this when the things are called through ntb_transport_edma? Or maybe a set_transport_type can be introduced by the transport itself during allocation?
>>>>>
>>>>> Agreed. I plan to drop 'use_remote_edma' and instead,
>>>>> - add a module parameter: transport_type={"default","edma"} (defaulting to "default"),
>>>>> - introduce ntb_transport_backend_register() for transports to self-register via
>>>>>   struct ntb_transport_backend { .name, .ops }, and
>>>>> - have the core select the backend whose .name matches transport_type.
>>>>>
>>>>> I think this should keep any non-default transport-specific logic out of
>>>>> ntb_transport_core, or at least keep it to a minimum, while still allowing
>>>>> non-defualt transports (*ntb_transport_edma is the only choice for now
>>>>> though) to plug in cleanly.
>>>>>
>>>>> If you see a cleaner approach, I would appreciate it if you could elaborate
>>>>> a bit more on your idea.
>>>>
>>>
>>> Thank you for the comment, let me respond inline below.
>>>
>>>> Do you think it's flexible enough that we can determine a transport type per 'ntb_transport_mw' or is this an all or nothing type of thing?
>>>
>>> At least in the current implementation, the remote eDMA use is an
>>> all-or-nothing type rather than something that can be selected per
>>> ntb_transport_mw.
>>>
>>> The way remote eDMA consumes MW is quite similar to how ntb_msi uses them
>>> today. Assuming multiple MWs are available, the last MW is reserved to
>>> expose the remote eDMA info/register/LL regions to the host by packing all
>>> of them into a single MW. In that sense, it does not map naturally to a
>>> per-MW selection model.
>>>
>>>> I'm trying to see if we can do away with the module param.
>>>
>>> I think it is useful to keep an explicit way for an administrator to choose
>>> the transport type (default vs edma). Even on platforms where dw-edma is
>>> available, there can potentially be platform-specific or hard-to-reproduce
>>> issues (e.g. problems that only show up with certain transfer patterns),
>>> and having a way to fall back the long-existing traditional transport can
>>> be valuable.
>>>
>>> That said, I am not opposed to making the default behavior an automatic
>>> selection, where edma is chosen when it's available and the parameter is
>>> left unset.
>>>
>>>> Or I guess when you probe ntb_netdev, the selection would happen there and thus transport_type would be in ntb_netdev module?
>>>
>>> I'm not sure how selecting the transport type at ntb_netdev probe time
>>> would work in practice, and what additional benefit that would provide.
>>
>> So currently ntb_netdev or ntb_transport are not auto-loaded right? They are manually probed by the user. So with the new transport, the user would modprobe ntb_transport_edma.ko. And that would trigger the eDMA transport setup right? With the ntb_transport_core library existing, we should be able to load both the ntb_transport_host and ntb_transport_edma at the same time theoretically. And ntb_netdev should be able to select one or the other transport. This is the most versatile scenario. An alternative is there can be only 1 transport ever loaded, and when ntb_transport_edma is loaded, it just looks like the default transport and netdev functions as it always has without knowing what the underneath transport is. On the platform if there are multiple NTB ports, it would be nice to have the flexibility of allowing each port choose the usage of the current transport and the edma transport if the user desires.
> 
> I was assuming manual load in my previous response. Also in this RFC v3,
> ntb_transport_edma is not even a standalone module yet (although I do think
> it should be). At this point, I feel the RFC v3 implementation is still a
> bit too rough to use as a basis for discussing the ideal long-term design,
> so I'd like to set it aside for a moment and focus on what the ideal shape
> could look like.
> 
> My current thoughts on the ideal structure, after reading your last
> comment, are as follows:
> 
> * The existing cpu/dma memcpy-based transport becomes "ntb_transport_host",
>   and the new eDMA-based transport becomes "ntb_transport_edma".
> * Each transport is a separate kernel module, and each provides its own
>   ntb_client implementation (i.e. each registers independently with the
>   NTB core). In this model, it should be perfectly fine for both modules to
>   be loaded at the same time.
> * Common pieces (e.g. ntb_transport_bus registration, shared helpers, and
>   the boundary/API exposed to ntb_transport_clients such as ntb_netdev)
>   should live in a shared library module, such as "ntb_transport_core" (or
>   "ntb_transport", naming TBD).
> 
> Then, for transport type selection:
> 
> * If we want to switch the transport type (host vs edma) on a per-NTB-port
>   (device) basis, we can rely on the standard driver override framework
>   (ie. driver_override, unbind/bind). To make that work, at first we need
>   to add driver_override support to ntb_bus.
> * In the case that ntb_netdev wants to explicitly select a transport type,
>   I think it should still be handled via the per-NTB-port driver_override
>   rather than building transport-selection logic into ntb_netdev itself
>   (perhaps with some extension to the boundary API for
>   ntb_transport_clients).
> * If ntb_transport_host / ntb_transport_edma are built-in modules, a
>   post-boot rebind might be sufficient in most cases. If that's not
>   sufficient, we could also consider providing a kernel parameter to define
>   a boot-time policy. For example, something like:
>     ntb_transport.policy=edma@0000:01:00.0,host@0000:5f:00.0
> 
> How doe that sound? In any case, I am planning to submit RFC v4.

Yup that sounds about what I was thinking. If you are submitting RFC v4 w/o the changes mentioned about, just mention that the progress is moving towards that in the cover letter to remind people. Thanks!

Any additional thoughts Jon?

> 
> Thanks for the review,
> Koichiro




