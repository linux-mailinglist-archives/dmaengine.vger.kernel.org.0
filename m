Return-Path: <dmaengine+bounces-7467-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2C9C9BDA0
	for <lists+dmaengine@lfdr.de>; Tue, 02 Dec 2025 15:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE6B3A7150
	for <lists+dmaengine@lfdr.de>; Tue,  2 Dec 2025 14:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B351F5437;
	Tue,  2 Dec 2025 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QjJ7J0sQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A669E19A2A3;
	Tue,  2 Dec 2025 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764686955; cv=none; b=QtDb6CBNUtGpkzXFPVruFNhZbwClunDZe6Qeo/7NSZA7tOBrVe0e9iAwWqNhWDLrGZZ+SCrh10YXPXuvxhxyfg+kiMd7NqOgCj2hbFTf6jnq5xHc7iByc2Ky+O850ba4wsaCIT96XbDLPhii1pa/PXs/SVMFLUauHekJv39VnZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764686955; c=relaxed/simple;
	bh=Cl1k5I7XFkRThZI4D+HTvkvuadLAhicPx5RXTab3AAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dM1uEpZamw5fxkwHTuj579izGSIyfsDPqjyfBJDPIUGpsBAr8nG83K/6PgDl/yORqp32o2PPe84JnOljNpfczcOOd2O5kMDHuWecmFSM50E/vNJYO5NDS+6kuoZ2FTeFFPgegYmB6KPR374h2A/E0dLiUxIPYkobVceNEyVsRgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QjJ7J0sQ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764686954; x=1796222954;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Cl1k5I7XFkRThZI4D+HTvkvuadLAhicPx5RXTab3AAE=;
  b=QjJ7J0sQM4G8ooFFwzNNtyaSeX2fMJAEVGzqftm4lQoiu/YZGmuQw4WN
   IoVneX14Z8GUoFrUugEC8/wp6OcLtSD//uYXDIO2gQqBQa5cV0Hmk1k2K
   AVAAsSb0QRolExNWfZskxdXumh4gikO/bqw1TUsdj5K6YCf1XtvI/ffSO
   Ttme4kO3euhnpwlK2u4vObqRVaRlx4jG3geoL6Vxu3j10G4iBZE+wSZtm
   GNWYASs8j0LHOFuGSRbj6SYlnTn2rKFbaEv7Hv8J5EnTQbCBmAXLFRYGm
   Hl2h86BBGcO1yG6PCy/9qA9EkbnWgUJEVNJXaNh4q8tNkRaJVAwwd0H/b
   Q==;
X-CSE-ConnectionGUID: UmPZivXMS9a0Ar3TBpgM6g==
X-CSE-MsgGUID: lyMhj+saQB+UZIbXTLb5Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="84254301"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="84254301"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 06:49:12 -0800
X-CSE-ConnectionGUID: qZsDMbeQRwuFhyaAK5ZcAQ==
X-CSE-MsgGUID: QT4IPoTwQZCJjZbFD53fUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="225356200"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.111.202]) ([10.125.111.202])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 06:49:10 -0800
Message-ID: <3c07161d-f1df-4409-a11c-b4a60afda226@intel.com>
Date: Tue, 2 Dec 2025 07:49:08 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 10/27] NTB: core: Add .get_pci_epc() to ntb_dev_ops
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, Frank.Li@nxp.com,
 mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
 bhelgaas@google.com, corbet@lwn.net, vkoul@kernel.org, jdmason@kudzu.us,
 allenbh@gmail.com, Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
 kurt.schwemmer@microsemi.com, logang@deltatee.com, jingoohan1@gmail.com,
 lpieralisi@kernel.org, robh@kernel.org, jbrunet@baylibre.com,
 fancer.lancer@gmail.com, arnd@arndb.de, pstanner@redhat.com,
 elfring@users.sourceforge.net
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-11-den@valinux.co.jp>
 <8b209241-99a7-42c0-8025-e75a11176f1b@intel.com>
 <f6jo2z4dnk23dun7g7d6d4ul2rw7do2cugb7jtq4tfb4vixzsw@lmpl5p4kqxc6>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <f6jo2z4dnk23dun7g7d6d4ul2rw7do2cugb7jtq4tfb4vixzsw@lmpl5p4kqxc6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/1/25 11:32 PM, Koichiro Den wrote:
> On Mon, Dec 01, 2025 at 02:08:14PM -0700, Dave Jiang wrote:
>>
>>
>> On 11/29/25 9:03 AM, Koichiro Den wrote:
>>> Add an optional get_pci_epc() callback to retrieve the underlying
>>> pci_epc device associated with the NTB implementation.
>>>
>>> Signed-off-by: Koichiro Den <den@valinux.co.jp>
>>> ---
>>>  drivers/ntb/hw/epf/ntb_hw_epf.c | 11 +----------
>>>  include/linux/ntb.h             | 21 +++++++++++++++++++++
>>>  2 files changed, 22 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
>>> index a3ec411bfe49..d55ce6b0fad4 100644
>>> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
>>> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
>>> @@ -9,6 +9,7 @@
>>>  #include <linux/delay.h>
>>>  #include <linux/module.h>
>>>  #include <linux/pci.h>
>>> +#include <linux/pci-epf.h>
>>>  #include <linux/slab.h>
>>>  #include <linux/ntb.h>
>>>  
>>> @@ -49,16 +50,6 @@
>>>  
>>>  #define NTB_EPF_COMMAND_TIMEOUT	1000 /* 1 Sec */
>>>  
>>> -enum pci_barno {
>>> -	NO_BAR = -1,
>>> -	BAR_0,
>>> -	BAR_1,
>>> -	BAR_2,
>>> -	BAR_3,
>>> -	BAR_4,
>>> -	BAR_5,
>>> -};
>>> -
>>>  enum epf_ntb_bar {
>>>  	BAR_CONFIG,
>>>  	BAR_PEER_SPAD,
>>> diff --git a/include/linux/ntb.h b/include/linux/ntb.h
>>> index d7ce5d2e60d0..04dc9a4d6b85 100644
>>> --- a/include/linux/ntb.h
>>> +++ b/include/linux/ntb.h
>>> @@ -64,6 +64,7 @@ struct ntb_client;
>>>  struct ntb_dev;
>>>  struct ntb_msi;
>>>  struct pci_dev;
>>> +struct pci_epc;
>>>  
>>>  /**
>>>   * enum ntb_topo - NTB connection topology
>>> @@ -256,6 +257,7 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
>>>   * @msg_clear_mask:	See ntb_msg_clear_mask().
>>>   * @msg_read:		See ntb_msg_read().
>>>   * @peer_msg_write:	See ntb_peer_msg_write().
>>> + * @get_pci_epc:	See ntb_get_pci_epc().
>>>   */
>>>  struct ntb_dev_ops {
>>>  	int (*port_number)(struct ntb_dev *ntb);
>>> @@ -331,6 +333,7 @@ struct ntb_dev_ops {
>>>  	int (*msg_clear_mask)(struct ntb_dev *ntb, u64 mask_bits);
>>>  	u32 (*msg_read)(struct ntb_dev *ntb, int *pidx, int midx);
>>>  	int (*peer_msg_write)(struct ntb_dev *ntb, int pidx, int midx, u32 msg);
>>> +	struct pci_epc *(*get_pci_epc)(struct ntb_dev *ntb);
>>
>> Seems very specific call to this particular hardware instead of something generic for the NTB dev ops. Maybe it should be something like get_private_data() or something like that?
> 
> Thank you for the suggestion.
> 
> I also felt that it's too specific, but I couldn't come up with a clean
> generic interface at the time, so I left it in this form.
> 
> .get_private_data() might indeed be better. In the callback doc comment we
> could describe it as "may be used to obtain a backing PCI controller
> pointer"?

I would add that comment in the defined callback for the hardware driver. For the actual API, it would be something like "for retrieving private data specific to the hardware driver"?

DJ

> 
> -Koichiro
> 
>>
>> DJ
>>
>>
>>>  };
>>>  
>>>  static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
>>> @@ -393,6 +396,9 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
>>>  		/* !ops->msg_clear_mask == !ops->msg_count	&& */
>>>  		!ops->msg_read == !ops->msg_count		&&
>>>  		!ops->peer_msg_write == !ops->msg_count		&&
>>> +
>>> +		/* Miscellaneous optional callbacks */
>>> +		/* ops->get_pci_epc			&& */
>>>  		1;
>>>  }
>>>  
>>> @@ -1567,6 +1573,21 @@ static inline int ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
>>>  	return ntb->ops->peer_msg_write(ntb, pidx, midx, msg);
>>>  }
>>>  
>>> +/**
>>> + * ntb_get_pci_epc() - get backing PCI endpoint controller if possible.
>>> + * @ntb:	NTB device context.
>>> + *
>>> + * Get the backing PCI endpoint controller representation.
>>> + *
>>> + * Return: A pointer to the pci_epc instance if available. or %NULL if not.
>>> + */
>>> +static inline struct pci_epc __maybe_unused *ntb_get_pci_epc(struct ntb_dev *ntb)
>>> +{
>>> +	if (!ntb->ops->get_pci_epc)
>>> +		return NULL;
>>> +	return ntb->ops->get_pci_epc(ntb);
>>> +}
>>> +
>>>  /**
>>>   * ntb_peer_resource_idx() - get a resource index for a given peer idx
>>>   * @ntb:	NTB device context.
>>


