Return-Path: <dmaengine+bounces-7444-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AA430C99235
	for <lists+dmaengine@lfdr.de>; Mon, 01 Dec 2025 22:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1DC74E2219
	for <lists+dmaengine@lfdr.de>; Mon,  1 Dec 2025 21:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFB72045AD;
	Mon,  1 Dec 2025 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MKPar0LM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C712080C8;
	Mon,  1 Dec 2025 21:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764623301; cv=none; b=jNFrasx2gm93u4vylVyuzUPCpTUrwSnVdxLIQhpDHoC3hGcA1eGY6NNtqCSgsx8ZhtH1zF2rjhZXlB9Rp0DSN8Tt5lMUXB3K544DFncvttnNXx9x3Lug/l7wVxZO0HuSlIC/GImjMhjwEMQMcY/chtVIVmwFFrqJZuJ3KgYF+CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764623301; c=relaxed/simple;
	bh=b+hVwcYZOl3pSJVCSR5ZKI5i2jwmT7T/w8L34wZGTXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c7y7OfjqLgFrI6jhtepjA2Xkqfg/Y8OCLLZsM7994Pqk1JYYRWAqF6qbVlMP4Q8+byG+Q39tgJZKr+wGILAfZZVCpOMdCZIlHlIT3wQXVpMUaUX+g5jvNex8TOggpHQkufwlM7zSJON+1qoYkFHKcYSR57IFlRdpAWifoS71iaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MKPar0LM; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764623300; x=1796159300;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b+hVwcYZOl3pSJVCSR5ZKI5i2jwmT7T/w8L34wZGTXo=;
  b=MKPar0LMoRLuTEsBPqyTICnjdErcljfAnpLCETX90UVNWKnWzBIjyMj1
   dLlh6gdglsBqKfV+Fx3IlnrQE6Z9Req2fGe64jWrPIyXiQ2Ky0c5hZNMk
   a/EMfoeZZiu6mjVDrV6H4if5t/e+kA6f+YIEcckIB/uX7MB6PttMh0HSu
   XsLuH30vRU+qQ2RTIDwBmIGnDH1cv++zbHDpMbsa4dOUQxIM3XcR2xTX0
   bbHBojg8S7QBq+qm9Ud6wjv5lxHU5y8zXH2sbXNOwIwOG5mjYCECcrVYy
   Kuaa9XhCp1bh425E5WaExNGe8+NA88iwSeEtSmiWJw3SbBT77G4yWIN9y
   Q==;
X-CSE-ConnectionGUID: MiPB8iR5RY+pCzKBHqORMw==
X-CSE-MsgGUID: h2SI00N0TBOOrRo7/xpB3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="77925318"
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="77925318"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 13:08:18 -0800
X-CSE-ConnectionGUID: 5Qj+ktSJSS2FhOVG1xTirQ==
X-CSE-MsgGUID: Q3S5ZokuTo6GlYSndpvbHA==
X-ExtLoop1: 1
Received: from tfalcon-desk.amr.corp.intel.com (HELO [10.125.111.120]) ([10.125.111.120])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 13:08:15 -0800
Message-ID: <8b209241-99a7-42c0-8025-e75a11176f1b@intel.com>
Date: Mon, 1 Dec 2025 14:08:14 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 10/27] NTB: core: Add .get_pci_epc() to ntb_dev_ops
To: Koichiro Den <den@valinux.co.jp>, ntb@lists.linux.dev,
 linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, Frank.Li@nxp.com
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
 bhelgaas@google.com, corbet@lwn.net, vkoul@kernel.org, jdmason@kudzu.us,
 allenbh@gmail.com, Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
 kurt.schwemmer@microsemi.com, logang@deltatee.com, jingoohan1@gmail.com,
 lpieralisi@kernel.org, robh@kernel.org, jbrunet@baylibre.com,
 fancer.lancer@gmail.com, arnd@arndb.de, pstanner@redhat.com,
 elfring@users.sourceforge.net
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-11-den@valinux.co.jp>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251129160405.2568284-11-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/29/25 9:03 AM, Koichiro Den wrote:
> Add an optional get_pci_epc() callback to retrieve the underlying
> pci_epc device associated with the NTB implementation.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 11 +----------
>  include/linux/ntb.h             | 21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index a3ec411bfe49..d55ce6b0fad4 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -9,6 +9,7 @@
>  #include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/pci-epf.h>
>  #include <linux/slab.h>
>  #include <linux/ntb.h>
>  
> @@ -49,16 +50,6 @@
>  
>  #define NTB_EPF_COMMAND_TIMEOUT	1000 /* 1 Sec */
>  
> -enum pci_barno {
> -	NO_BAR = -1,
> -	BAR_0,
> -	BAR_1,
> -	BAR_2,
> -	BAR_3,
> -	BAR_4,
> -	BAR_5,
> -};
> -
>  enum epf_ntb_bar {
>  	BAR_CONFIG,
>  	BAR_PEER_SPAD,
> diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> index d7ce5d2e60d0..04dc9a4d6b85 100644
> --- a/include/linux/ntb.h
> +++ b/include/linux/ntb.h
> @@ -64,6 +64,7 @@ struct ntb_client;
>  struct ntb_dev;
>  struct ntb_msi;
>  struct pci_dev;
> +struct pci_epc;
>  
>  /**
>   * enum ntb_topo - NTB connection topology
> @@ -256,6 +257,7 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
>   * @msg_clear_mask:	See ntb_msg_clear_mask().
>   * @msg_read:		See ntb_msg_read().
>   * @peer_msg_write:	See ntb_peer_msg_write().
> + * @get_pci_epc:	See ntb_get_pci_epc().
>   */
>  struct ntb_dev_ops {
>  	int (*port_number)(struct ntb_dev *ntb);
> @@ -331,6 +333,7 @@ struct ntb_dev_ops {
>  	int (*msg_clear_mask)(struct ntb_dev *ntb, u64 mask_bits);
>  	u32 (*msg_read)(struct ntb_dev *ntb, int *pidx, int midx);
>  	int (*peer_msg_write)(struct ntb_dev *ntb, int pidx, int midx, u32 msg);
> +	struct pci_epc *(*get_pci_epc)(struct ntb_dev *ntb);

Seems very specific call to this particular hardware instead of something generic for the NTB dev ops. Maybe it should be something like get_private_data() or something like that?

DJ


>  };
>  
>  static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
> @@ -393,6 +396,9 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
>  		/* !ops->msg_clear_mask == !ops->msg_count	&& */
>  		!ops->msg_read == !ops->msg_count		&&
>  		!ops->peer_msg_write == !ops->msg_count		&&
> +
> +		/* Miscellaneous optional callbacks */
> +		/* ops->get_pci_epc			&& */
>  		1;
>  }
>  
> @@ -1567,6 +1573,21 @@ static inline int ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
>  	return ntb->ops->peer_msg_write(ntb, pidx, midx, msg);
>  }
>  
> +/**
> + * ntb_get_pci_epc() - get backing PCI endpoint controller if possible.
> + * @ntb:	NTB device context.
> + *
> + * Get the backing PCI endpoint controller representation.
> + *
> + * Return: A pointer to the pci_epc instance if available. or %NULL if not.
> + */
> +static inline struct pci_epc __maybe_unused *ntb_get_pci_epc(struct ntb_dev *ntb)
> +{
> +	if (!ntb->ops->get_pci_epc)
> +		return NULL;
> +	return ntb->ops->get_pci_epc(ntb);
> +}
> +
>  /**
>   * ntb_peer_resource_idx() - get a resource index for a given peer idx
>   * @ntb:	NTB device context.


