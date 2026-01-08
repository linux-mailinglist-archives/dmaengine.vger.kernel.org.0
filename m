Return-Path: <dmaengine+bounces-8130-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CEAD05A32
	for <lists+dmaengine@lfdr.de>; Thu, 08 Jan 2026 19:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13727314C26F
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jan 2026 17:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ACA2E8897;
	Thu,  8 Jan 2026 17:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MNEpuExC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2522E7F0A;
	Thu,  8 Jan 2026 17:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767894954; cv=none; b=H/s7DP4fSAfCQnrShCT0W1uzFkd4P9vyNQTYbfc8CmElnLfTKZmiDv2QwYIaE6y2scQAd/v21f7LJWCKyGYgKNJhlxpYtyjB9Y53OJBBlS7qgSkGIeybSU2jYaMidVNAdoT23SCrefX7ad+Mu+cBoVXw6iXfK2m1cEbdeag35x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767894954; c=relaxed/simple;
	bh=+Fa0hifhGlchTYdpqcrqARHHey22di9gkd6hroHz9s4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EJKyd/GhRk2FpxcHR3Ecsi7MbWxNO+4RSxiviMtOEAcmW35vpr/GHxn+M1+THFGH6smqg3UNb0x60l2pXtGBFUhYJZjpJOgPCAxi5kjGW332ArAArN7RBEVA6g3Ias4J9cMyRUetEYPQ0LR5f8FuTUj+5OVcVW+9C4xlx+t60lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MNEpuExC; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767894952; x=1799430952;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+Fa0hifhGlchTYdpqcrqARHHey22di9gkd6hroHz9s4=;
  b=MNEpuExCP9zn66+ovokut0hFeDAzf/Yfrnm/n8rcmXalbmmf3jx+Q+PG
   EuepHJe0+oqWh1Dj++nPi7ipsho3FTGlLGxc9I5v/SamAmmEu/NkeEL9A
   dQ5Af5ol7Zid4ihM99YicmDrvg9F0SBu4CDmdxpzLALEYp2Eoh4CEtesU
   zTyF9qCNfXaVsF8D3aWgMuXAwZ5qStnOWJMFBnAW0imfF5g2+K5PqrFAR
   iefOYW5CpICCavbdYLb7T4HUZuew3vRnkkfzN/e2g8HTNdnPJihouiwMT
   YBXI3hZEJPdbIT7s3fsJTC1Zv7uGNnhS5hRXo47ZF9LJcuUhoMb+0cw6J
   w==;
X-CSE-ConnectionGUID: wMFx4p9URyWFrwfc/JwXQg==
X-CSE-MsgGUID: imuriOjhTUiPL0CeIVc0xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="94751425"
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="94751425"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 09:55:50 -0800
X-CSE-ConnectionGUID: OPCGqI7wQ7iJfsgWzylGAw==
X-CSE-MsgGUID: 57IvlF7ZSfeOUtYg8Wjfvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="207802923"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.109.207]) ([10.125.109.207])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 09:55:48 -0800
Message-ID: <71fd5c95-3734-479f-b1dd-9a2b48fdeb74@intel.com>
Date: Thu, 8 Jan 2026 10:55:46 -0700
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
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <rlqffb3dnvalfjj4vcbmqkraqxmqdv5vd4tpqq2cssyuwrydc3@ujkesovxdgfy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/7/26 6:25 PM, Koichiro Den wrote:
> On Wed, Jan 07, 2026 at 12:02:15PM -0700, Dave Jiang wrote:
>>
>>
>> On 1/7/26 7:54 AM, Koichiro Den wrote:
>>> On Tue, Jan 06, 2026 at 11:51:03AM -0700, Dave Jiang wrote:
>>>>
>>>>
>>>> On 12/17/25 8:16 AM, Koichiro Den wrote:
>>>>> Add a new ntb_transport backend that uses a DesignWare eDMA engine
>>>>> located on the endpoint, to be driven by both host and endpoint.
>>>>>
>>>>> The endpoint exposes a dedicated memory window which contains the eDMA
>>>>> register block, a small control structure (struct ntb_edma_info) and
>>>>> per-channel linked-list (LL) rings for read channels. Endpoint drives
>>>>> its local eDMA write channels for its transmission, while host side
>>>>> uses the remote eDMA read channels for its transmission.
>>>>>
>>>>> A key benefit of this backend is that the memory window no longer needs
>>>>> to carry data-plane payload. This makes the design less sensitive to
>>>>> limited memory window space and allows scaling to multiple queue pairs.
>>>>> The memory window layout is specific to the eDMA-backed backend, so
>>>>> there is no automatic fallback to the memcpy-based default transport
>>>>> that requires the different layout.
>>>>>
>>>>> Signed-off-by: Koichiro Den <den@valinux.co.jp>
>>>>> ---
>>>>>  drivers/ntb/Kconfig                  |  12 +
>>>>>  drivers/ntb/Makefile                 |   2 +
>>>>>  drivers/ntb/ntb_transport_core.c     |  15 +-
>>>>>  drivers/ntb/ntb_transport_edma.c     | 987 +++++++++++++++++++++++++++
>>>>>  drivers/ntb/ntb_transport_internal.h |  15 +
>>>>>  5 files changed, 1029 insertions(+), 2 deletions(-)
>>>>>  create mode 100644 drivers/ntb/ntb_transport_edma.c
>>>>>
>>>>> diff --git a/drivers/ntb/Kconfig b/drivers/ntb/Kconfig
>>>>> index df16c755b4da..5ba6d0b7f5ba 100644
>>>>> --- a/drivers/ntb/Kconfig
>>>>> +++ b/drivers/ntb/Kconfig
>>>>> @@ -37,4 +37,16 @@ config NTB_TRANSPORT
>>>>>  
>>>>>  	 If unsure, say N.
>>>>>  
>>>>> +config NTB_TRANSPORT_EDMA
>>>>> +	bool "NTB Transport backed by remote eDMA"
>>>>> +	depends on NTB_TRANSPORT
>>>>> +	depends on PCI
>>>>> +	select DMA_ENGINE
>>>>> +	select NTB_EDMA
>>>>> +	help
>>>>> +	  Enable a transport backend that uses a remote DesignWare eDMA engine
>>>>> +	  exposed through a dedicated NTB memory window. The host uses the
>>>>> +	  endpoint's eDMA engine to move data in both directions.
>>>>> +	  Say Y here if you intend to use the 'use_remote_edma' module parameter.
>>>>> +
>>>>>  endif # NTB
>>>>> diff --git a/drivers/ntb/Makefile b/drivers/ntb/Makefile
>>>>> index 9b66e5fafbc0..b9086b32ecde 100644
>>>>> --- a/drivers/ntb/Makefile
>>>>> +++ b/drivers/ntb/Makefile
>>>>> @@ -6,3 +6,5 @@ ntb-y			:= core.o
>>>>>  ntb-$(CONFIG_NTB_MSI)	+= msi.o
>>>>>  
>>>>>  ntb_transport-y		:= ntb_transport_core.o
>>>>> +ntb_transport-$(CONFIG_NTB_TRANSPORT_EDMA)	+= ntb_transport_edma.o
>>>>> +ntb_transport-$(CONFIG_NTB_TRANSPORT_EDMA)	+= hw/edma/ntb_hw_edma.o
>>>>> diff --git a/drivers/ntb/ntb_transport_core.c b/drivers/ntb/ntb_transport_core.c
>>>>> index 40c2548f5930..bd21232f26fe 100644
>>>>> --- a/drivers/ntb/ntb_transport_core.c
>>>>> +++ b/drivers/ntb/ntb_transport_core.c
>>>>> @@ -104,6 +104,12 @@ module_param(use_msi, bool, 0644);
>>>>>  MODULE_PARM_DESC(use_msi, "Use MSI interrupts instead of doorbells");
>>>>>  #endif
>>>>>  
>>>>> +bool use_remote_edma;
>>>>> +#ifdef CONFIG_NTB_TRANSPORT_EDMA
>>>>> +module_param(use_remote_edma, bool, 0644);
>>>>> +MODULE_PARM_DESC(use_remote_edma, "Use remote eDMA mode (when enabled, use_msi is ignored)");
>>>>> +#endif
>>>>
>>>> This seems clunky. Can the ntb_transport_core determine this when the things are called through ntb_transport_edma? Or maybe a set_transport_type can be introduced by the transport itself during allocation?
>>>
>>> Agreed. I plan to drop 'use_remote_edma' and instead,
>>> - add a module parameter: transport_type={"default","edma"} (defaulting to "default"),
>>> - introduce ntb_transport_backend_register() for transports to self-register via
>>>   struct ntb_transport_backend { .name, .ops }, and
>>> - have the core select the backend whose .name matches transport_type.
>>>
>>> I think this should keep any non-default transport-specific logic out of
>>> ntb_transport_core, or at least keep it to a minimum, while still allowing
>>> non-defualt transports (*ntb_transport_edma is the only choice for now
>>> though) to plug in cleanly.
>>>
>>> If you see a cleaner approach, I would appreciate it if you could elaborate
>>> a bit more on your idea.
>>
> 
> Thank you for the comment, let me respond inline below.
> 
>> Do you think it's flexible enough that we can determine a transport type per 'ntb_transport_mw' or is this an all or nothing type of thing?
> 
> At least in the current implementation, the remote eDMA use is an
> all-or-nothing type rather than something that can be selected per
> ntb_transport_mw.
> 
> The way remote eDMA consumes MW is quite similar to how ntb_msi uses them
> today. Assuming multiple MWs are available, the last MW is reserved to
> expose the remote eDMA info/register/LL regions to the host by packing all
> of them into a single MW. In that sense, it does not map naturally to a
> per-MW selection model.
> 
>> I'm trying to see if we can do away with the module param.
> 
> I think it is useful to keep an explicit way for an administrator to choose
> the transport type (default vs edma). Even on platforms where dw-edma is
> available, there can potentially be platform-specific or hard-to-reproduce
> issues (e.g. problems that only show up with certain transfer patterns),
> and having a way to fall back the long-existing traditional transport can
> be valuable.
> 
> That said, I am not opposed to making the default behavior an automatic
> selection, where edma is chosen when it's available and the parameter is
> left unset.
> 
>> Or I guess when you probe ntb_netdev, the selection would happen there and thus transport_type would be in ntb_netdev module?
> 
> I'm not sure how selecting the transport type at ntb_netdev probe time
> would work in practice, and what additional benefit that would provide.

So currently ntb_netdev or ntb_transport are not auto-loaded right? They are manually probed by the user. So with the new transport, the user would modprobe ntb_transport_edma.ko. And that would trigger the eDMA transport setup right? With the ntb_transport_core library existing, we should be able to load both the ntb_transport_host and ntb_transport_edma at the same time theoretically. And ntb_netdev should be able to select one or the other transport. This is the most versatile scenario. An alternative is there can be only 1 transport ever loaded, and when ntb_transport_edma is loaded, it just looks like the default transport and netdev functions as it always has without knowing what the underneath transport is. On the platform if there are multiple NTB ports, it would be nice to have the flexibility of allowing each port choose the usage of the current transport and the edma transport if the user desires.

DJ

> 
> Kind regards,
> Koichiro
> 
>>
>>>
>>> Thanks,
>>> Koichiro
>>>
>>>>
>>>> DJ
>>>>
>>>>> +
>>>>>  static struct dentry *nt_debugfs_dir;
>>>>>  
>>>>>  /* Only two-ports NTB devices are supported */
>>>>> @@ -156,7 +162,7 @@ enum {
>>>>>  #define drv_client(__drv) \
>>>>>  	container_of((__drv), struct ntb_transport_client, driver)
>>>>>  
>>>>> -#define NTB_QP_DEF_NUM_ENTRIES	100
>>>>> +#define NTB_QP_DEF_NUM_ENTRIES	128
>>>>>  #define NTB_LINK_DOWN_TIMEOUT	10
>>>>>  
>>>>>  static void ntb_transport_rxc_db(unsigned long data);
>>>>> @@ -1189,7 +1195,11 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
>>>>>  
>>>>>  	nt->ndev = ndev;
>>>>>  
>>>>> -	rc = ntb_transport_default_init(nt);
>>>>> +	if (use_remote_edma)
>>>>> +		rc = ntb_transport_edma_init(nt);
>>>>> +	else
>>>>> +		rc = ntb_transport_default_init(nt);
>>>>> +
>>>>>  	if (rc)
>>>>>  		return rc;
>>>>>  
>>>>> @@ -1950,6 +1960,7 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
>>>>>  
>>>>>  	nt->qp_bitmap_free &= ~qp_bit;
>>>>>  
>>>>> +	qp->qp_bit = qp_bit;
>>>>>  	qp->cb_data = data;
>>>>>  	qp->rx_handler = handlers->rx_handler;
>>>>>  	qp->tx_handler = handlers->tx_handler;
>>>>> diff --git a/drivers/ntb/ntb_transport_edma.c b/drivers/ntb/ntb_transport_edma.c
>>>>> new file mode 100644
>>>>> index 000000000000..6ae5da0a1367
>>>>> --- /dev/null
>>>>> +++ b/drivers/ntb/ntb_transport_edma.c
>>>>> @@ -0,0 +1,987 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>>> +/*
>>>>> + * NTB transport backend for remote DesignWare eDMA.
>>>>> + *
>>>>> + * This implements the backend_ops used when use_remote_edma=1 and
>>>>> + * relies on drivers/ntb/hw/edma/ for low-level eDMA/MW programming.
>>>>> + */
>>>>> +
>>>>> +#include <linux/bug.h>
>>>>> +#include <linux/compiler.h>
>>>>> +#include <linux/debugfs.h>
>>>>> +#include <linux/dmaengine.h>
>>>>> +#include <linux/dma-mapping.h>
>>>>> +#include <linux/errno.h>
>>>>> +#include <linux/io-64-nonatomic-lo-hi.h>
>>>>> +#include <linux/ntb.h>
>>>>> +#include <linux/pci.h>
>>>>> +#include <linux/pci-epc.h>
>>>>> +#include <linux/seq_file.h>
>>>>> +#include <linux/slab.h>
>>>>> +
>>>>> +#include "hw/edma/ntb_hw_edma.h"
>>>>> +#include "ntb_transport_internal.h"
>>>>> +
>>>>> +#define NTB_EDMA_RING_ORDER	7
>>>>> +#define NTB_EDMA_RING_ENTRIES	(1U << NTB_EDMA_RING_ORDER)
>>>>> +#define NTB_EDMA_RING_MASK	(NTB_EDMA_RING_ENTRIES - 1)
>>>>> +
>>>>> +#define NTB_EDMA_MAX_POLL	32
>>>>> +
>>>>> +/*
>>>>> + * Remote eDMA mode implementation
>>>>> + */
>>>>> +struct ntb_transport_ctx_edma {
>>>>> +	remote_edma_mode_t remote_edma_mode;
>>>>> +	struct device *dma_dev;
>>>>> +	struct workqueue_struct *wq;
>>>>> +	struct ntb_edma_chans chans;
>>>>> +};
>>>>> +
>>>>> +struct ntb_transport_qp_edma {
>>>>> +	struct ntb_transport_qp *qp;
>>>>> +
>>>>> +	/*
>>>>> +	 * For ensuring peer notification in non-atomic context.
>>>>> +	 * ntb_peer_db_set might sleep or schedule.
>>>>> +	 */
>>>>> +	struct work_struct db_work;
>>>>> +
>>>>> +	u32 rx_prod;
>>>>> +	u32 rx_cons;
>>>>> +	u32 tx_cons;
>>>>> +	u32 tx_issue;
>>>>> +
>>>>> +	spinlock_t rx_lock;
>>>>> +	spinlock_t tx_lock;
>>>>> +
>>>>> +	struct work_struct rx_work;
>>>>> +	struct work_struct tx_work;
>>>>> +};
>>>>> +
>>>>> +struct ntb_edma_desc {
>>>>> +	u32 len;
>>>>> +	u32 flags;
>>>>> +	u64 addr; /* DMA address */
>>>>> +	u64 data;
>>>>> +};
>>>>> +
>>>>> +struct ntb_edma_ring {
>>>>> +	struct ntb_edma_desc desc[NTB_EDMA_RING_ENTRIES];
>>>>> +	u32 head;
>>>>> +	u32 tail;
>>>>> +};
>>>>> +
>>>>> +static inline bool ntb_qp_edma_is_rc(struct ntb_transport_qp *qp)
>>>>> +{
>>>>> +	struct ntb_transport_ctx_edma *ctx = qp->transport->priv;
>>>>> +
>>>>> +	return ctx->remote_edma_mode == REMOTE_EDMA_RC;
>>>>> +}
>>>>> +
>>>>> +static inline bool ntb_qp_edma_is_ep(struct ntb_transport_qp *qp)
>>>>> +{
>>>>> +	struct ntb_transport_ctx_edma *ctx = qp->transport->priv;
>>>>> +
>>>>> +	return ctx->remote_edma_mode == REMOTE_EDMA_EP;
>>>>> +}
>>>>> +
>>>>> +static inline bool ntb_qp_edma_enabled(struct ntb_transport_qp *qp)
>>>>> +{
>>>>> +	return ntb_qp_edma_is_rc(qp) || ntb_qp_edma_is_ep(qp);
>>>>> +}
>>>>> +
>>>>> +static inline unsigned int ntb_edma_ring_sel(struct ntb_transport_qp *qp,
>>>>> +					     unsigned int n)
>>>>> +{
>>>>> +	return n ^ !!ntb_qp_edma_is_ep(qp);
>>>>> +}
>>>>> +
>>>>> +static inline struct ntb_edma_ring *
>>>>> +ntb_edma_ring_local(struct ntb_transport_qp *qp, unsigned int n)
>>>>> +{
>>>>> +	unsigned int r = ntb_edma_ring_sel(qp, n);
>>>>> +
>>>>> +	return &((struct ntb_edma_ring *)qp->rx_buff)[r];
>>>>> +}
>>>>> +
>>>>> +static inline struct ntb_edma_ring __iomem *
>>>>> +ntb_edma_ring_remote(struct ntb_transport_qp *qp, unsigned int n)
>>>>> +{
>>>>> +	unsigned int r = ntb_edma_ring_sel(qp, n);
>>>>> +
>>>>> +	return &((struct ntb_edma_ring __iomem *)qp->tx_mw)[r];
>>>>> +}
>>>>> +
>>>>> +static inline struct ntb_edma_desc *
>>>>> +ntb_edma_desc_local(struct ntb_transport_qp *qp, unsigned int n, unsigned int i)
>>>>> +{
>>>>> +	return &ntb_edma_ring_local(qp, n)->desc[i];
>>>>> +}
>>>>> +
>>>>> +static inline struct ntb_edma_desc __iomem *
>>>>> +ntb_edma_desc_remote(struct ntb_transport_qp *qp, unsigned int n,
>>>>> +		     unsigned int i)
>>>>> +{
>>>>> +	return &ntb_edma_ring_remote(qp, n)->desc[i];
>>>>> +}
>>>>> +
>>>>> +static inline u32 *ntb_edma_head_local(struct ntb_transport_qp *qp,
>>>>> +				       unsigned int n)
>>>>> +{
>>>>> +	return &ntb_edma_ring_local(qp, n)->head;
>>>>> +}
>>>>> +
>>>>> +static inline u32 __iomem *ntb_edma_head_remote(struct ntb_transport_qp *qp,
>>>>> +						unsigned int n)
>>>>> +{
>>>>> +	return &ntb_edma_ring_remote(qp, n)->head;
>>>>> +}
>>>>> +
>>>>> +static inline u32 *ntb_edma_tail_local(struct ntb_transport_qp *qp,
>>>>> +				       unsigned int n)
>>>>> +{
>>>>> +	return &ntb_edma_ring_local(qp, n)->tail;
>>>>> +}
>>>>> +
>>>>> +static inline u32 __iomem *ntb_edma_tail_remote(struct ntb_transport_qp *qp,
>>>>> +						unsigned int n)
>>>>> +{
>>>>> +	return &ntb_edma_ring_remote(qp, n)->tail;
>>>>> +}
>>>>> +
>>>>> +/* The 'i' must be generated by ntb_edma_ring_idx() */
>>>>> +#define NTB_DESC_TX_O(qp, i)	ntb_edma_desc_remote(qp, 0, i)
>>>>> +#define NTB_DESC_TX_I(qp, i)	ntb_edma_desc_local(qp, 0, i)
>>>>> +#define NTB_DESC_RX_O(qp, i)	ntb_edma_desc_remote(qp, 1, i)
>>>>> +#define NTB_DESC_RX_I(qp, i)	ntb_edma_desc_local(qp, 1, i)
>>>>> +
>>>>> +#define NTB_HEAD_TX_I(qp)	ntb_edma_head_local(qp, 0)
>>>>> +#define NTB_HEAD_RX_O(qp)	ntb_edma_head_remote(qp, 1)
>>>>> +
>>>>> +#define NTB_TAIL_TX_O(qp)	ntb_edma_tail_remote(qp, 0)
>>>>> +#define NTB_TAIL_RX_I(qp)	ntb_edma_tail_local(qp, 1)
>>>>> +
>>>>> +/* ntb_edma_ring helpers */
>>>>> +static __always_inline u32 ntb_edma_ring_idx(u32 v)
>>>>> +{
>>>>> +	return v & NTB_EDMA_RING_MASK;
>>>>> +}
>>>>> +
>>>>> +static __always_inline u32 ntb_edma_ring_used_entry(u32 head, u32 tail)
>>>>> +{
>>>>> +	if (head >= tail) {
>>>>> +		WARN_ON_ONCE((head - tail) > (NTB_EDMA_RING_ENTRIES - 1));
>>>>> +		return head - tail;
>>>>> +	}
>>>>> +
>>>>> +	WARN_ON_ONCE((U32_MAX - tail + head + 1) > (NTB_EDMA_RING_ENTRIES - 1));
>>>>> +	return U32_MAX - tail + head + 1;
>>>>> +}
>>>>> +
>>>>> +static __always_inline u32 ntb_edma_ring_free_entry(u32 head, u32 tail)
>>>>> +{
>>>>> +	return NTB_EDMA_RING_ENTRIES - ntb_edma_ring_used_entry(head, tail) - 1;
>>>>> +}
>>>>> +
>>>>> +static __always_inline bool ntb_edma_ring_full(u32 head, u32 tail)
>>>>> +{
>>>>> +	return ntb_edma_ring_free_entry(head, tail) == 0;
>>>>> +}
>>>>> +
>>>>> +static unsigned int ntb_transport_edma_tx_free_entry(struct ntb_transport_qp *qp)
>>>>> +{
>>>>> +	struct ntb_transport_qp_edma *edma = qp->priv;
>>>>> +	unsigned int head, tail;
>>>>> +
>>>>> +	scoped_guard(spinlock_irqsave, &edma->tx_lock) {
>>>>> +		/* In this scope, only 'head' might proceed */
>>>>> +		tail = READ_ONCE(edma->tx_issue);
>>>>> +		head = READ_ONCE(*NTB_HEAD_TX_I(qp));
>>>>> +	}
>>>>> +	/*
>>>>> +	 * 'used' amount indicates how much the other end has refilled,
>>>>> +	 * which are available for us to use for TX.
>>>>> +	 */
>>>>> +	return ntb_edma_ring_used_entry(head, tail);
>>>>> +}
>>>>> +
>>>>> +static void ntb_transport_edma_debugfs_stats_show(struct seq_file *s,
>>>>> +						  struct ntb_transport_qp *qp)
>>>>> +{
>>>>> +	seq_printf(s, "rx_bytes - \t%llu\n", qp->rx_bytes);
>>>>> +	seq_printf(s, "rx_pkts - \t%llu\n", qp->rx_pkts);
>>>>> +	seq_printf(s, "rx_err_no_buf - %llu\n", qp->rx_err_no_buf);
>>>>> +	seq_printf(s, "rx_buff - \t0x%p\n", qp->rx_buff);
>>>>> +	seq_printf(s, "rx_max_entry - \t%u\n", qp->rx_max_entry);
>>>>> +	seq_printf(s, "rx_alloc_entry - \t%u\n\n", qp->rx_alloc_entry);
>>>>> +
>>>>> +	seq_printf(s, "tx_bytes - \t%llu\n", qp->tx_bytes);
>>>>> +	seq_printf(s, "tx_pkts - \t%llu\n", qp->tx_pkts);
>>>>> +	seq_printf(s, "tx_ring_full - \t%llu\n", qp->tx_ring_full);
>>>>> +	seq_printf(s, "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
>>>>> +	seq_printf(s, "tx_mw - \t0x%p\n", qp->tx_mw);
>>>>> +	seq_printf(s, "tx_max_entry - \t%u\n", qp->tx_max_entry);
>>>>> +	seq_printf(s, "free tx - \t%u\n", ntb_transport_tx_free_entry(qp));
>>>>> +	seq_putc(s, '\n');
>>>>> +
>>>>> +	seq_puts(s, "Using Remote eDMA - Yes\n");
>>>>> +	seq_printf(s, "QP Link - \t%s\n", qp->link_is_up ? "Up" : "Down");
>>>>> +}
>>>>> +
>>>>> +static void ntb_transport_edma_uninit(struct ntb_transport_ctx *nt)
>>>>> +{
>>>>> +	struct ntb_transport_ctx_edma *ctx = nt->priv;
>>>>> +
>>>>> +	if (ctx->wq)
>>>>> +		destroy_workqueue(ctx->wq);
>>>>> +	ctx->wq = NULL;
>>>>> +
>>>>> +	ntb_edma_teardown_chans(&ctx->chans);
>>>>> +
>>>>> +	switch (ctx->remote_edma_mode) {
>>>>> +	case REMOTE_EDMA_EP:
>>>>> +		ntb_edma_teardown_mws(nt->ndev);
>>>>> +		break;
>>>>> +	case REMOTE_EDMA_RC:
>>>>> +		ntb_edma_teardown_peer(nt->ndev);
>>>>> +		break;
>>>>> +	case REMOTE_EDMA_UNKNOWN:
>>>>> +	default:
>>>>> +		break;
>>>>> +	}
>>>>> +
>>>>> +	ctx->remote_edma_mode = REMOTE_EDMA_UNKNOWN;
>>>>> +}
>>>>> +
>>>>> +static void ntb_transport_edma_db_work(struct work_struct *work)
>>>>> +{
>>>>> +	struct ntb_transport_qp_edma *edma =
>>>>> +			container_of(work, struct ntb_transport_qp_edma, db_work);
>>>>> +	struct ntb_transport_qp *qp = edma->qp;
>>>>> +
>>>>> +	ntb_peer_db_set(qp->ndev, qp->qp_bit);
>>>>> +}
>>>>> +
>>>>> +static void ntb_transport_edma_notify_peer(struct ntb_transport_qp_edma *edma)
>>>>> +{
>>>>> +	struct ntb_transport_qp *qp = edma->qp;
>>>>> +	struct ntb_transport_ctx_edma *ctx = qp->transport->priv;
>>>>> +
>>>>> +	if (!ntb_edma_notify_peer(&ctx->chans, qp->qp_num))
>>>>> +		return;
>>>>> +
>>>>> +	/*
>>>>> +	 * Called from contexts that may be atomic. Since ntb_peer_db_set()
>>>>> +	 * may sleep, delegate the actual doorbell write to a workqueue.
>>>>> +	 */
>>>>> +	queue_work(system_highpri_wq, &edma->db_work);
>>>>> +}
>>>>> +
>>>>> +static void ntb_transport_edma_isr(void *data, int qp_num)
>>>>> +{
>>>>> +	struct ntb_transport_ctx *nt = data;
>>>>> +	struct ntb_transport_qp_edma *edma;
>>>>> +	struct ntb_transport_ctx_edma *ctx;
>>>>> +	struct ntb_transport_qp *qp;
>>>>> +
>>>>> +	if (qp_num < 0 || qp_num >= nt->qp_count)
>>>>> +		return;
>>>>> +
>>>>> +	qp = &nt->qp_vec[qp_num];
>>>>> +	if (WARN_ON(!qp))
>>>>> +		return;
>>>>> +
>>>>> +	ctx = (struct ntb_transport_ctx_edma *)qp->transport->priv;
>>>>> +	edma = qp->priv;
>>>>> +
>>>>> +	queue_work(ctx->wq, &edma->rx_work);
>>>>> +	queue_work(ctx->wq, &edma->tx_work);
>>>>> +}
>>>>> +
>>>>> +static int ntb_transport_edma_rc_init(struct ntb_transport_ctx *nt)
>>>>> +{
>>>>> +	struct ntb_transport_ctx_edma *ctx = nt->priv;
>>>>> +	struct ntb_dev *ndev = nt->ndev;
>>>>> +	struct pci_dev *pdev = ndev->pdev;
>>>>> +	int peer_mw;
>>>>> +	int rc;
>>>>> +
>>>>> +	if (!use_remote_edma || ctx->remote_edma_mode != REMOTE_EDMA_UNKNOWN)
>>>>> +		return 0;
>>>>> +
>>>>> +	peer_mw = ntb_peer_mw_count(ndev);
>>>>> +	if (peer_mw <= 0)
>>>>> +		return -ENODEV;
>>>>> +
>>>>> +	rc = ntb_edma_setup_peer(ndev, peer_mw - 1, nt->qp_count);
>>>>> +	if (rc) {
>>>>> +		dev_err(&pdev->dev, "Failed to enable remote eDMA: %d\n", rc);
>>>>> +		return rc;
>>>>> +	}
>>>>> +
>>>>> +	rc = ntb_edma_setup_chans(get_dma_dev(ndev), &ctx->chans, true);
>>>>> +	if (rc) {
>>>>> +		dev_err(&pdev->dev, "Failed to setup eDMA channels: %d\n", rc);
>>>>> +		goto err_teardown_peer;
>>>>> +	}
>>>>> +
>>>>> +	rc = ntb_edma_setup_intr_chan(get_dma_dev(ndev), &ctx->chans);
>>>>> +	if (rc) {
>>>>> +		dev_err(&pdev->dev, "Failed to setup eDMA notify channel: %d\n",
>>>>> +			rc);
>>>>> +		goto err_teardown_chans;
>>>>> +	}
>>>>> +
>>>>> +	ctx->remote_edma_mode = REMOTE_EDMA_RC;
>>>>> +	return 0;
>>>>> +
>>>>> +err_teardown_chans:
>>>>> +	ntb_edma_teardown_chans(&ctx->chans);
>>>>> +err_teardown_peer:
>>>>> +	ntb_edma_teardown_peer(ndev);
>>>>> +	return rc;
>>>>> +}
>>>>> +
>>>>> +
>>>>> +static int ntb_transport_edma_ep_init(struct ntb_transport_ctx *nt)
>>>>> +{
>>>>> +	struct ntb_transport_ctx_edma *ctx = nt->priv;
>>>>> +	struct ntb_dev *ndev = nt->ndev;
>>>>> +	struct pci_dev *pdev = ndev->pdev;
>>>>> +	int peer_mw;
>>>>> +	int rc;
>>>>> +
>>>>> +	if (!use_remote_edma || ctx->remote_edma_mode == REMOTE_EDMA_EP)
>>>>> +		return 0;
>>>>> +
>>>>> +	/**
>>>>> +	 * This check assumes that the endpoint (pci-epf-vntb.c)
>>>>> +	 * ntb_dev_ops implements .get_private_data() while the host side
>>>>> +	 * (ntb_hw_epf.c) does not.
>>>>> +	 */
>>>>> +	if (!ntb_get_private_data(ndev))
>>>>> +		return 0;
>>>>> +
>>>>> +	peer_mw = ntb_peer_mw_count(ndev);
>>>>> +	if (peer_mw <= 0)
>>>>> +		return -ENODEV;
>>>>> +
>>>>> +	rc = ntb_edma_setup_mws(ndev, peer_mw - 1, nt->qp_count,
>>>>> +				ntb_transport_edma_isr, nt);
>>>>> +	if (rc) {
>>>>> +		dev_err(&pdev->dev,
>>>>> +			"Failed to set up memory window for eDMA: %d\n", rc);
>>>>> +		return rc;
>>>>> +	}
>>>>> +
>>>>> +	rc = ntb_edma_setup_chans(get_dma_dev(ndev), &ctx->chans, false);
>>>>> +	if (rc) {
>>>>> +		dev_err(&pdev->dev, "Failed to setup eDMA channels: %d\n", rc);
>>>>> +		ntb_edma_teardown_mws(ndev);
>>>>> +		return rc;
>>>>> +	}
>>>>> +
>>>>> +	ctx->remote_edma_mode = REMOTE_EDMA_EP;
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +
>>>>> +static int ntb_transport_edma_setup_qp_mw(struct ntb_transport_ctx *nt,
>>>>> +					  unsigned int qp_num)
>>>>> +{
>>>>> +	struct ntb_transport_qp *qp = &nt->qp_vec[qp_num];
>>>>> +	struct ntb_dev *ndev = nt->ndev;
>>>>> +	struct ntb_queue_entry *entry;
>>>>> +	struct ntb_transport_mw *mw;
>>>>> +	unsigned int mw_num, mw_count, qp_count;
>>>>> +	unsigned int qp_offset, rx_info_offset;
>>>>> +	unsigned int mw_size, mw_size_per_qp;
>>>>> +	unsigned int num_qps_mw;
>>>>> +	size_t edma_total;
>>>>> +	unsigned int i;
>>>>> +	int node;
>>>>> +
>>>>> +	mw_count = nt->mw_count;
>>>>> +	qp_count = nt->qp_count;
>>>>> +
>>>>> +	mw_num = QP_TO_MW(nt, qp_num);
>>>>> +	mw = &nt->mw_vec[mw_num];
>>>>> +
>>>>> +	if (!mw->virt_addr)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	if (mw_num < qp_count % mw_count)
>>>>> +		num_qps_mw = qp_count / mw_count + 1;
>>>>> +	else
>>>>> +		num_qps_mw = qp_count / mw_count;
>>>>> +
>>>>> +	mw_size = min(nt->mw_vec[mw_num].phys_size, mw->xlat_size);
>>>>> +	if (max_mw_size && mw_size > max_mw_size)
>>>>> +		mw_size = max_mw_size;
>>>>> +
>>>>> +	mw_size_per_qp = round_down((unsigned int)mw_size / num_qps_mw, SZ_64);
>>>>> +	qp_offset = mw_size_per_qp * (qp_num / mw_count);
>>>>> +	rx_info_offset = mw_size_per_qp - sizeof(struct ntb_rx_info);
>>>>> +
>>>>> +	qp->tx_mw_size = mw_size_per_qp;
>>>>> +	qp->tx_mw = nt->mw_vec[mw_num].vbase + qp_offset;
>>>>> +	if (!qp->tx_mw)
>>>>> +		return -EINVAL;
>>>>> +	qp->tx_mw_phys = nt->mw_vec[mw_num].phys_addr + qp_offset;
>>>>> +	if (!qp->tx_mw_phys)
>>>>> +		return -EINVAL;
>>>>> +	qp->rx_info = qp->tx_mw + rx_info_offset;
>>>>> +	qp->rx_buff = mw->virt_addr + qp_offset;
>>>>> +	qp->remote_rx_info = qp->rx_buff + rx_info_offset;
>>>>> +
>>>>> +	/* Due to housekeeping, there must be at least 2 buffs */
>>>>> +	qp->tx_max_frame = min(transport_mtu, mw_size_per_qp / 2);
>>>>> +	qp->rx_max_frame = min(transport_mtu, mw_size_per_qp / 2);
>>>>> +
>>>>> +	/* In eDMA mode, decouple from MW sizing and force ring-sized entries */
>>>>> +	edma_total = 2 * sizeof(struct ntb_edma_ring);
>>>>> +	if (rx_info_offset < edma_total) {
>>>>> +		dev_err(&ndev->dev, "Ring space requires %zuB (>=%uB)\n",
>>>>> +			edma_total, rx_info_offset);
>>>>> +		return -EINVAL;
>>>>> +	}
>>>>> +	qp->tx_max_entry = NTB_EDMA_RING_ENTRIES;
>>>>> +	qp->rx_max_entry = NTB_EDMA_RING_ENTRIES;
>>>>> +
>>>>> +	/*
>>>>> +	 * Checking to see if we have more entries than the default.
>>>>> +	 * We should add additional entries if that is the case so we
>>>>> +	 * can be in sync with the transport frames.
>>>>> +	 */
>>>>> +	node = dev_to_node(&ndev->dev);
>>>>> +	for (i = qp->rx_alloc_entry; i < qp->rx_max_entry; i++) {
>>>>> +		entry = kzalloc_node(sizeof(*entry), GFP_KERNEL, node);
>>>>> +		if (!entry)
>>>>> +			return -ENOMEM;
>>>>> +
>>>>> +		entry->qp = qp;
>>>>> +		ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry,
>>>>> +			     &qp->rx_free_q);
>>>>> +		qp->rx_alloc_entry++;
>>>>> +	}
>>>>> +
>>>>> +	memset(qp->rx_buff, 0, edma_total);
>>>>> +
>>>>> +	qp->rx_pkts = 0;
>>>>> +	qp->tx_pkts = 0;
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static int ntb_transport_edma_rx_complete(struct ntb_transport_qp *qp)
>>>>> +{
>>>>> +	struct device *dma_dev = get_dma_dev(qp->ndev);
>>>>> +	struct ntb_transport_qp_edma *edma = qp->priv;
>>>>> +	struct ntb_queue_entry *entry;
>>>>> +	struct ntb_edma_desc *in;
>>>>> +	unsigned int len;
>>>>> +	bool link_down;
>>>>> +	u32 idx;
>>>>> +
>>>>> +	if (ntb_edma_ring_used_entry(READ_ONCE(*NTB_TAIL_RX_I(qp)),
>>>>> +				     edma->rx_cons) == 0)
>>>>> +		return 0;
>>>>> +
>>>>> +	idx = ntb_edma_ring_idx(edma->rx_cons);
>>>>> +	in = NTB_DESC_RX_I(qp, idx);
>>>>> +	if (!(in->flags & DESC_DONE_FLAG))
>>>>> +		return 0;
>>>>> +
>>>>> +	link_down = in->flags & LINK_DOWN_FLAG;
>>>>> +	in->flags = 0;
>>>>> +	len = in->len; /* might be smaller than entry->len */
>>>>> +
>>>>> +	entry = (struct ntb_queue_entry *)(uintptr_t)in->data;
>>>>> +	if (WARN_ON(!entry))
>>>>> +		return 0;
>>>>> +
>>>>> +	if (link_down) {
>>>>> +		ntb_qp_link_down(qp);
>>>>> +		edma->rx_cons++;
>>>>> +		ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_free_q);
>>>>> +		return 1;
>>>>> +	}
>>>>> +
>>>>> +	dma_unmap_single(dma_dev, entry->addr, entry->len, DMA_FROM_DEVICE);
>>>>> +
>>>>> +	qp->rx_bytes += len;
>>>>> +	qp->rx_pkts++;
>>>>> +	edma->rx_cons++;
>>>>> +
>>>>> +	if (qp->rx_handler && qp->client_ready)
>>>>> +		qp->rx_handler(qp, qp->cb_data, entry->cb_data, len);
>>>>> +
>>>>> +	ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_free_q);
>>>>> +	return 1;
>>>>> +}
>>>>> +
>>>>> +static void ntb_transport_edma_rx_work(struct work_struct *work)
>>>>> +{
>>>>> +	struct ntb_transport_qp_edma *edma = container_of(
>>>>> +				work, struct ntb_transport_qp_edma, rx_work);
>>>>> +	struct ntb_transport_qp *qp = edma->qp;
>>>>> +	struct ntb_transport_ctx_edma *ctx = qp->transport->priv;
>>>>> +	unsigned int i;
>>>>> +
>>>>> +	for (i = 0; i < NTB_EDMA_MAX_POLL; i++) {
>>>>> +		if (!ntb_transport_edma_rx_complete(qp))
>>>>> +			break;
>>>>> +	}
>>>>> +
>>>>> +	if (ntb_transport_edma_rx_complete(qp))
>>>>> +		queue_work(ctx->wq, &edma->rx_work);
>>>>> +}
>>>>> +
>>>>> +static void ntb_transport_edma_tx_work(struct work_struct *work)
>>>>> +{
>>>>> +	struct ntb_transport_qp_edma *edma = container_of(
>>>>> +				work, struct ntb_transport_qp_edma, tx_work);
>>>>> +	struct ntb_transport_qp *qp = edma->qp;
>>>>> +	struct ntb_edma_desc *in, __iomem *out;
>>>>> +	struct ntb_queue_entry *entry;
>>>>> +	unsigned int len;
>>>>> +	void *cb_data;
>>>>> +	u32 idx;
>>>>> +
>>>>> +	while (ntb_edma_ring_used_entry(READ_ONCE(edma->tx_issue),
>>>>> +					edma->tx_cons) != 0) {
>>>>> +		/* Paired with smp_wmb() in ntb_transport_edma_tx_enqueue_inner() */
>>>>> +		smp_rmb();
>>>>> +
>>>>> +		idx = ntb_edma_ring_idx(edma->tx_cons);
>>>>> +		in = NTB_DESC_TX_I(qp, idx);
>>>>> +		entry = (struct ntb_queue_entry *)(uintptr_t)in->data;
>>>>> +		if (!entry || !(entry->flags & DESC_DONE_FLAG))
>>>>> +			break;
>>>>> +
>>>>> +		in->data = 0;
>>>>> +
>>>>> +		cb_data = entry->cb_data;
>>>>> +		len = entry->len;
>>>>> +
>>>>> +		out = NTB_DESC_TX_O(qp, idx);
>>>>> +
>>>>> +		WRITE_ONCE(edma->tx_cons, edma->tx_cons + 1);
>>>>> +
>>>>> +		/*
>>>>> +		 * No need to add barrier in-between to enforce ordering here.
>>>>> +		 * The other side proceeds only after both flags and tail are
>>>>> +		 * updated.
>>>>> +		 */
>>>>> +		iowrite32(entry->flags, &out->flags);
>>>>> +		iowrite32(edma->tx_cons, NTB_TAIL_TX_O(qp));
>>>>> +
>>>>> +		ntb_transport_edma_notify_peer(edma);
>>>>> +
>>>>> +		ntb_list_add(&qp->ntb_tx_free_q_lock, &entry->entry,
>>>>> +			     &qp->tx_free_q);
>>>>> +
>>>>> +		if (qp->tx_handler)
>>>>> +			qp->tx_handler(qp, qp->cb_data, cb_data, len);
>>>>> +
>>>>> +		/* stat updates */
>>>>> +		qp->tx_bytes += len;
>>>>> +		qp->tx_pkts++;
>>>>> +	}
>>>>> +}
>>>>> +
>>>>> +static void ntb_transport_edma_tx_cb(void *data,
>>>>> +				     const struct dmaengine_result *res)
>>>>> +{
>>>>> +	struct ntb_queue_entry *entry = data;
>>>>> +	struct ntb_transport_qp *qp = entry->qp;
>>>>> +	struct ntb_transport_ctx *nt = qp->transport;
>>>>> +	struct device *dma_dev = get_dma_dev(qp->ndev);
>>>>> +	enum dmaengine_tx_result dma_err = res->result;
>>>>> +	struct ntb_transport_ctx_edma *ctx = nt->priv;
>>>>> +	struct ntb_transport_qp_edma *edma = qp->priv;
>>>>> +
>>>>> +	switch (dma_err) {
>>>>> +	case DMA_TRANS_READ_FAILED:
>>>>> +	case DMA_TRANS_WRITE_FAILED:
>>>>> +	case DMA_TRANS_ABORTED:
>>>>> +		entry->errors++;
>>>>> +		entry->len = -EIO;
>>>>> +		break;
>>>>> +	case DMA_TRANS_NOERROR:
>>>>> +	default:
>>>>> +		break;
>>>>> +	}
>>>>> +	dma_unmap_sg(dma_dev, &entry->sgl, 1, DMA_TO_DEVICE);
>>>>> +	sg_dma_address(&entry->sgl) = 0;
>>>>> +
>>>>> +	entry->flags |= DESC_DONE_FLAG;
>>>>> +
>>>>> +	queue_work(ctx->wq, &edma->tx_work);
>>>>> +}
>>>>> +
>>>>> +static int ntb_transport_edma_submit(struct device *d, struct dma_chan *chan,
>>>>> +				     size_t len, void *rc_src, dma_addr_t dst,
>>>>> +				     struct ntb_queue_entry *entry)
>>>>> +{
>>>>> +	struct scatterlist *sgl = &entry->sgl;
>>>>> +	struct dma_async_tx_descriptor *txd;
>>>>> +	struct dma_slave_config cfg;
>>>>> +	dma_cookie_t cookie;
>>>>> +	int nents, rc;
>>>>> +
>>>>> +	if (!d)
>>>>> +		return -ENODEV;
>>>>> +
>>>>> +	if (!chan)
>>>>> +		return -ENXIO;
>>>>> +
>>>>> +	if (WARN_ON(!rc_src || !dst))
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	if (WARN_ON(sg_dma_address(sgl)))
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	sg_init_one(sgl, rc_src, len);
>>>>> +	nents = dma_map_sg(d, sgl, 1, DMA_TO_DEVICE);
>>>>> +	if (nents <= 0)
>>>>> +		return -EIO;
>>>>> +
>>>>> +	memset(&cfg, 0, sizeof(cfg));
>>>>> +	cfg.dst_addr       = dst;
>>>>> +	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>>>>> +	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>>>>> +	cfg.direction      = DMA_MEM_TO_DEV;
>>>>> +
>>>>> +	txd = dmaengine_prep_slave_sg_config(chan, sgl, 1, DMA_MEM_TO_DEV,
>>>>> +				      DMA_CTRL_ACK | DMA_PREP_INTERRUPT, &cfg);
>>>>> +	if (!txd) {
>>>>> +		rc = -EIO;
>>>>> +		goto out_unmap;
>>>>> +	}
>>>>> +
>>>>> +	txd->callback_result = ntb_transport_edma_tx_cb;
>>>>> +	txd->callback_param = entry;
>>>>> +
>>>>> +	cookie = dmaengine_submit(txd);
>>>>> +	if (dma_submit_error(cookie)) {
>>>>> +		rc = -EIO;
>>>>> +		goto out_unmap;
>>>>> +	}
>>>>> +	dma_async_issue_pending(chan);
>>>>> +	return 0;
>>>>> +out_unmap:
>>>>> +	dma_unmap_sg(d, sgl, 1, DMA_TO_DEVICE);
>>>>> +	return rc;
>>>>> +}
>>>>> +
>>>>> +static int ntb_transport_edma_tx_enqueue_inner(struct ntb_transport_qp *qp,
>>>>> +					       struct ntb_queue_entry *entry)
>>>>> +{
>>>>> +	struct device *dma_dev = get_dma_dev(qp->ndev);
>>>>> +	struct ntb_transport_qp_edma *edma = qp->priv;
>>>>> +	struct ntb_transport_ctx *nt = qp->transport;
>>>>> +	struct ntb_edma_desc *in, __iomem *out;
>>>>> +	struct ntb_transport_ctx_edma *ctx = nt->priv;
>>>>> +	unsigned int len = entry->len;
>>>>> +	struct dma_chan *chan;
>>>>> +	u32 issue, idx, head;
>>>>> +	dma_addr_t dst;
>>>>> +	int rc;
>>>>> +
>>>>> +	WARN_ON_ONCE(entry->flags & DESC_DONE_FLAG);
>>>>> +
>>>>> +	scoped_guard(spinlock_irqsave, &edma->tx_lock) {
>>>>> +		head = READ_ONCE(*NTB_HEAD_TX_I(qp));
>>>>> +		issue = edma->tx_issue;
>>>>> +		if (ntb_edma_ring_used_entry(head, issue) == 0) {
>>>>> +			qp->tx_ring_full++;
>>>>> +			return -ENOSPC;
>>>>> +		}
>>>>> +
>>>>> +		/*
>>>>> +		 * ntb_transport_edma_tx_work() checks entry->flags
>>>>> +		 * so it needs to be set before tx_issue++.
>>>>> +		 */
>>>>> +		idx = ntb_edma_ring_idx(issue);
>>>>> +		in = NTB_DESC_TX_I(qp, idx);
>>>>> +		in->data = (uintptr_t)entry;
>>>>> +
>>>>> +		/* Make in->data visible before tx_issue++ */
>>>>> +		smp_wmb();
>>>>> +
>>>>> +		WRITE_ONCE(edma->tx_issue, edma->tx_issue + 1);
>>>>> +	}
>>>>> +
>>>>> +	/* Publish the final transfer length to the other end */
>>>>> +	out = NTB_DESC_TX_O(qp, idx);
>>>>> +	iowrite32(len, &out->len);
>>>>> +	ioread32(&out->len);
>>>>> +
>>>>> +	if (unlikely(!len)) {
>>>>> +		entry->flags |= DESC_DONE_FLAG;
>>>>> +		queue_work(ctx->wq, &edma->tx_work);
>>>>> +		return 0;
>>>>> +	}
>>>>> +
>>>>> +	/* Paired with dma_wmb() in ntb_transport_edma_rx_enqueue_inner() */
>>>>> +	dma_rmb();
>>>>> +
>>>>> +	/* kick remote eDMA read transfer */
>>>>> +	dst = (dma_addr_t)in->addr;
>>>>> +	chan = ntb_edma_pick_chan(&ctx->chans, qp->qp_num);
>>>>> +	rc = ntb_transport_edma_submit(dma_dev, chan, len,
>>>>> +					      entry->buf, dst, entry);
>>>>> +	if (rc) {
>>>>> +		entry->errors++;
>>>>> +		entry->len = -EIO;
>>>>> +		entry->flags |= DESC_DONE_FLAG;
>>>>> +		queue_work(ctx->wq, &edma->tx_work);
>>>>> +	}
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static int ntb_transport_edma_tx_enqueue(struct ntb_transport_qp *qp,
>>>>> +					 struct ntb_queue_entry *entry,
>>>>> +					 void *cb, void *data, unsigned int len,
>>>>> +					 unsigned int flags)
>>>>> +{
>>>>> +	struct device *dma_dev;
>>>>> +
>>>>> +	if (entry->addr) {
>>>>> +		/* Deferred unmap */
>>>>> +		dma_dev = get_dma_dev(qp->ndev);
>>>>> +		dma_unmap_single(dma_dev, entry->addr, entry->len,
>>>>> +				 DMA_TO_DEVICE);
>>>>> +	}
>>>>> +
>>>>> +	entry->cb_data = cb;
>>>>> +	entry->buf = data;
>>>>> +	entry->len = len;
>>>>> +	entry->flags = flags;
>>>>> +	entry->errors = 0;
>>>>> +	entry->addr = 0;
>>>>> +
>>>>> +	WARN_ON_ONCE(!ntb_qp_edma_enabled(qp));
>>>>> +
>>>>> +	return ntb_transport_edma_tx_enqueue_inner(qp, entry);
>>>>> +}
>>>>> +
>>>>> +static int ntb_transport_edma_rx_enqueue_inner(struct ntb_transport_qp *qp,
>>>>> +					       struct ntb_queue_entry *entry)
>>>>> +{
>>>>> +	struct device *dma_dev = get_dma_dev(qp->ndev);
>>>>> +	struct ntb_transport_qp_edma *edma = qp->priv;
>>>>> +	struct ntb_edma_desc *in, __iomem *out;
>>>>> +	unsigned int len = entry->len;
>>>>> +	void *data = entry->buf;
>>>>> +	dma_addr_t dst;
>>>>> +	u32 idx;
>>>>> +	int rc;
>>>>> +
>>>>> +	dst = dma_map_single(dma_dev, data, len, DMA_FROM_DEVICE);
>>>>> +	rc = dma_mapping_error(dma_dev, dst);
>>>>> +	if (rc)
>>>>> +		return rc;
>>>>> +
>>>>> +	guard(spinlock_bh)(&edma->rx_lock);
>>>>> +
>>>>> +	if (ntb_edma_ring_full(READ_ONCE(edma->rx_prod),
>>>>> +			       READ_ONCE(edma->rx_cons))) {
>>>>> +		rc = -ENOSPC;
>>>>> +		goto out_unmap;
>>>>> +	}
>>>>> +
>>>>> +	idx = ntb_edma_ring_idx(edma->rx_prod);
>>>>> +	in = NTB_DESC_RX_I(qp, idx);
>>>>> +	out = NTB_DESC_RX_O(qp, idx);
>>>>> +
>>>>> +	iowrite32(len, &out->len);
>>>>> +	iowrite64(dst, &out->addr);
>>>>> +
>>>>> +	WARN_ON(in->flags & DESC_DONE_FLAG);
>>>>> +	in->data = (uintptr_t)entry;
>>>>> +	entry->addr = dst;
>>>>> +
>>>>> +	/* Ensure len/addr are visible before the head update */
>>>>> +	dma_wmb();
>>>>> +
>>>>> +	WRITE_ONCE(edma->rx_prod, edma->rx_prod + 1);
>>>>> +	iowrite32(edma->rx_prod, NTB_HEAD_RX_O(qp));
>>>>> +
>>>>> +	return 0;
>>>>> +out_unmap:
>>>>> +	dma_unmap_single(dma_dev, dst, len, DMA_FROM_DEVICE);
>>>>> +	return rc;
>>>>> +}
>>>>> +
>>>>> +static int ntb_transport_edma_rx_enqueue(struct ntb_transport_qp *qp,
>>>>> +					 struct ntb_queue_entry *entry)
>>>>> +{
>>>>> +	int rc;
>>>>> +
>>>>> +	rc = ntb_transport_edma_rx_enqueue_inner(qp, entry);
>>>>> +	if (rc) {
>>>>> +		ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry,
>>>>> +			     &qp->rx_free_q);
>>>>> +		return rc;
>>>>> +	}
>>>>> +
>>>>> +	ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_pend_q);
>>>>> +
>>>>> +	if (qp->active)
>>>>> +		tasklet_schedule(&qp->rxc_db_work);
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static void ntb_transport_edma_rx_poll(struct ntb_transport_qp *qp)
>>>>> +{
>>>>> +	struct ntb_transport_ctx *nt = qp->transport;
>>>>> +	struct ntb_transport_ctx_edma *ctx = nt->priv;
>>>>> +	struct ntb_transport_qp_edma *edma = qp->priv;
>>>>> +
>>>>> +	queue_work(ctx->wq, &edma->rx_work);
>>>>> +	queue_work(ctx->wq, &edma->tx_work);
>>>>> +}
>>>>> +
>>>>> +static int ntb_transport_edma_qp_init(struct ntb_transport_ctx *nt,
>>>>> +				      unsigned int qp_num)
>>>>> +{
>>>>> +	struct ntb_transport_qp *qp = &nt->qp_vec[qp_num];
>>>>> +	struct ntb_transport_qp_edma *edma;
>>>>> +	struct ntb_dev *ndev = nt->ndev;
>>>>> +	int node;
>>>>> +
>>>>> +	node = dev_to_node(&ndev->dev);
>>>>> +
>>>>> +	qp->priv = kzalloc_node(sizeof(*edma), GFP_KERNEL, node);
>>>>> +	if (!qp->priv)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	edma = (struct ntb_transport_qp_edma *)qp->priv;
>>>>> +	edma->qp = qp;
>>>>> +	edma->rx_prod = 0;
>>>>> +	edma->rx_cons = 0;
>>>>> +	edma->tx_cons = 0;
>>>>> +	edma->tx_issue = 0;
>>>>> +
>>>>> +	spin_lock_init(&edma->rx_lock);
>>>>> +	spin_lock_init(&edma->tx_lock);
>>>>> +
>>>>> +	INIT_WORK(&edma->db_work, ntb_transport_edma_db_work);
>>>>> +	INIT_WORK(&edma->rx_work, ntb_transport_edma_rx_work);
>>>>> +	INIT_WORK(&edma->tx_work, ntb_transport_edma_tx_work);
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static void ntb_transport_edma_qp_free(struct ntb_transport_qp *qp)
>>>>> +{
>>>>> +	struct ntb_transport_qp_edma *edma = qp->priv;
>>>>> +
>>>>> +	cancel_work_sync(&edma->db_work);
>>>>> +	cancel_work_sync(&edma->rx_work);
>>>>> +	cancel_work_sync(&edma->tx_work);
>>>>> +
>>>>> +	kfree(qp->priv);
>>>>> +}
>>>>> +
>>>>> +static int ntb_transport_edma_pre_link_up(struct ntb_transport_ctx *nt)
>>>>> +{
>>>>> +	struct ntb_dev *ndev = nt->ndev;
>>>>> +	struct pci_dev *pdev = ndev->pdev;
>>>>> +	int rc;
>>>>> +
>>>>> +	rc = ntb_transport_edma_ep_init(nt);
>>>>> +	if (rc)
>>>>> +		dev_err(&pdev->dev, "Failed to init EP: %d\n", rc);
>>>>> +
>>>>> +	return rc;
>>>>> +}
>>>>> +
>>>>> +static int ntb_transport_edma_post_link_up(struct ntb_transport_ctx *nt)
>>>>> +{
>>>>> +	struct ntb_dev *ndev = nt->ndev;
>>>>> +	struct pci_dev *pdev = ndev->pdev;
>>>>> +	int rc;
>>>>> +
>>>>> +	rc = ntb_transport_edma_rc_init(nt);
>>>>> +	if (rc)
>>>>> +		dev_err(&pdev->dev, "Failed to init RC: %d\n", rc);
>>>>> +
>>>>> +	return rc;
>>>>> +}
>>>>> +
>>>>> +static int ntb_transport_edma_enable(struct ntb_transport_ctx *nt,
>>>>> +				     unsigned int *mw_count)
>>>>> +{
>>>>> +	struct ntb_dev *ndev = nt->ndev;
>>>>> +	struct ntb_transport_ctx_edma *ctx = nt->priv;
>>>>> +
>>>>> +	if (!use_remote_edma)
>>>>> +		return 0;
>>>>> +
>>>>> +	/*
>>>>> +	 * We need at least one MW for the transport plus one MW reserved
>>>>> +	 * for the remote eDMA window (see ntb_edma_setup_mws/peer).
>>>>> +	 */
>>>>> +	if (*mw_count <= 1) {
>>>>> +		dev_err(&ndev->dev,
>>>>> +			"remote eDMA requires at least two MWS (have %u)\n",
>>>>> +			*mw_count);
>>>>> +		return -ENODEV;
>>>>> +	}
>>>>> +
>>>>> +	ctx->wq = alloc_workqueue("ntb-edma-wq", WQ_UNBOUND | WQ_SYSFS, 0);
>>>>> +	if (!ctx->wq) {
>>>>> +		ntb_transport_edma_uninit(nt);
>>>>> +		return -ENOMEM;
>>>>> +	}
>>>>> +
>>>>> +	/* Reserve the last peer MW exclusively for the eDMA window. */
>>>>> +	*mw_count -= 1;
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static void ntb_transport_edma_disable(struct ntb_transport_ctx *nt)
>>>>> +{
>>>>> +	ntb_transport_edma_uninit(nt);
>>>>> +}
>>>>> +
>>>>> +static const struct ntb_transport_backend_ops edma_backend_ops = {
>>>>> +	.enable = ntb_transport_edma_enable,
>>>>> +	.disable = ntb_transport_edma_disable,
>>>>> +	.qp_init = ntb_transport_edma_qp_init,
>>>>> +	.qp_free = ntb_transport_edma_qp_free,
>>>>> +	.pre_link_up = ntb_transport_edma_pre_link_up,
>>>>> +	.post_link_up = ntb_transport_edma_post_link_up,
>>>>> +	.setup_qp_mw = ntb_transport_edma_setup_qp_mw,
>>>>> +	.tx_free_entry = ntb_transport_edma_tx_free_entry,
>>>>> +	.tx_enqueue = ntb_transport_edma_tx_enqueue,
>>>>> +	.rx_enqueue = ntb_transport_edma_rx_enqueue,
>>>>> +	.rx_poll = ntb_transport_edma_rx_poll,
>>>>> +	.debugfs_stats_show = ntb_transport_edma_debugfs_stats_show,
>>>>> +};
>>>>> +
>>>>> +int ntb_transport_edma_init(struct ntb_transport_ctx *nt)
>>>>> +{
>>>>> +	struct ntb_dev *ndev = nt->ndev;
>>>>> +	int node;
>>>>> +
>>>>> +	node = dev_to_node(&ndev->dev);
>>>>> +	nt->priv = kzalloc_node(sizeof(struct ntb_transport_ctx_edma), GFP_KERNEL,
>>>>> +				node);
>>>>> +	if (!nt->priv)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	nt->backend_ops = edma_backend_ops;
>>>>> +	/*
>>>>> +	 * On remote eDMA mode, one DMA read channel is used for Host side
>>>>> +	 * to interrupt EP.
>>>>> +	 */
>>>>> +	use_msi = false;
>>>>> +	return 0;
>>>>> +}
>>>>> diff --git a/drivers/ntb/ntb_transport_internal.h b/drivers/ntb/ntb_transport_internal.h
>>>>> index 51ff08062d73..9fff65980d3d 100644
>>>>> --- a/drivers/ntb/ntb_transport_internal.h
>>>>> +++ b/drivers/ntb/ntb_transport_internal.h
>>>>> @@ -8,6 +8,7 @@
>>>>>  extern unsigned long max_mw_size;
>>>>>  extern unsigned int transport_mtu;
>>>>>  extern bool use_msi;
>>>>> +extern bool use_remote_edma;
>>>>>  
>>>>>  #define QP_TO_MW(nt, qp)	((qp) % nt->mw_count)
>>>>>  
>>>>> @@ -29,6 +30,11 @@ struct ntb_queue_entry {
>>>>>  		struct ntb_payload_header __iomem *tx_hdr;
>>>>>  		struct ntb_payload_header *rx_hdr;
>>>>>  	};
>>>>> +
>>>>> +#ifdef CONFIG_NTB_TRANSPORT_EDMA
>>>>> +	dma_addr_t addr;
>>>>> +	struct scatterlist sgl;
>>>>> +#endif
>>>>>  };
>>>>>  
>>>>>  struct ntb_rx_info {
>>>>> @@ -202,4 +208,13 @@ int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
>>>>>  			     unsigned int qp_num);
>>>>>  struct device *get_dma_dev(struct ntb_dev *ndev);
>>>>>  
>>>>> +#ifdef CONFIG_NTB_TRANSPORT_EDMA
>>>>> +int ntb_transport_edma_init(struct ntb_transport_ctx *nt);
>>>>> +#else
>>>>> +static inline int ntb_transport_edma_init(struct ntb_transport_ctx *nt)
>>>>> +{
>>>>> +	return -EOPNOTSUPP;
>>>>> +}
>>>>> +#endif /* CONFIG_NTB_TRANSPORT_EDMA */
>>>>> +
>>>>>  #endif /* _NTB_TRANSPORT_INTERNAL_H_ */
>>>>
>>
> 


