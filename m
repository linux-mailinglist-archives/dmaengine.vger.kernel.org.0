Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6949F35493A
	for <lists+dmaengine@lfdr.de>; Tue,  6 Apr 2021 01:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241536AbhDEXbR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Apr 2021 19:31:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:2946 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237964AbhDEXbQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 5 Apr 2021 19:31:16 -0400
IronPort-SDR: BWprA6bsk+sinE3KzrGI8pG/cbPQKEJ6r3cFx8zC/y0Ogk0OB+dYawz92h6rSplfGEcs87ZMZ3
 3fiVEdsdQLcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="193056498"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="193056498"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 16:31:09 -0700
IronPort-SDR: 34fJnRXCX11uOz9Fy+2XL/B3aG5x89X4cL2o48cYTPpI9z89I/R6xiyuNS3VnAjxHG4kLjGV9F
 kj5QOu4e3Tfg==
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="447604995"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.254.114.157]) ([10.254.114.157])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 16:31:08 -0700
Subject: Re: [PATCH] dmaengine: idxd: make idxd_name constant
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
References: <161314339610.2231590.18332704779939143434.stgit@djiang5-desk3.ch.intel.com>
Message-ID: <7888116b-4d77-17ee-c79a-73a3b602d099@intel.com>
Date:   Mon, 5 Apr 2021 16:31:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <161314339610.2231590.18332704779939143434.stgit@djiang5-desk3.ch.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 2/12/2021 8:23 AM, Dave Jiang wrote:
> idxd_name is a string table and should be constant.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

This patch can be dropped. It's no longer relevant with this patch.

https://lore.kernel.org/dmaengine/161739347672.2945060.13854255339674044108.stgit@djiang5-desk3.ch.intel.com/T/#u



> ---
>   drivers/dma/idxd/init.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 1df624eee6db..7fa147b1d29e 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -47,7 +47,7 @@ static struct pci_device_id idxd_pci_tbl[] = {
>   };
>   MODULE_DEVICE_TABLE(pci, idxd_pci_tbl);
>   
> -static char *idxd_name[] = {
> +static const char * const idxd_name[] = {
>   	"dsa",
>   	"iax"
>   };
>
>
