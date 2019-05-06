Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9733614933
	for <lists+dmaengine@lfdr.de>; Mon,  6 May 2019 13:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbfEFL46 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 May 2019 07:56:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbfEFL46 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 6 May 2019 07:56:58 -0400
Received: from localhost (unknown [106.200.210.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A1C920830;
        Mon,  6 May 2019 11:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557143817;
        bh=l3Q9zYtpJDlezkY5Df/NNkgOt/6+oZ4CRStgYt952UE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wDUwJmY86Cyl33de6+ugixEzPcQtbx+1DoYxNYVaVNSx48CL63+lc3jYVdlKIfAf5
         FUjGTqHAOBla0qt4mkZWiloFr5RD+wivvK4usglIymoFTaNtpDTW7GnjZV5HK5j8bl
         F2f3+ydufvMtlane37VxCMPXWwRPodnJ9vzb7icA=
Date:   Mon, 6 May 2019 17:26:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [RFC v6 2/6] dmaengine: Add Synopsys eDMA IP version 0 support
Message-ID: <20190506115651.GF3845@vkoul-mobl.Dlink>
References: <cover.1556043127.git.gustavo.pimentel@synopsys.com>
 <9e75b8f3a66cce4242265e64636f50a6672969d0.1556043127.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e75b8f3a66cce4242265e64636f50a6672969d0.1556043127.git.gustavo.pimentel@synopsys.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-04-19, 20:30, Gustavo Pimentel wrote:

> +struct dw_edma_v0_regs {
> +	/* eDMA global registers */
> +	u32 ctrl_data_arb_prior;			/* 0x000 */
> +	u32 padding_1;					/* 0x004 */
> +	u32 ctrl;					/* 0x008 */
> +	u32 wr_engine_en;				/* 0x00c */
> +	u32 wr_doorbell;				/* 0x010 */
> +	u32 padding_2;					/* 0x014 */
> +	u32 wr_ch_arb_weight_low;			/* 0x018 */
> +	u32 wr_ch_arb_weight_high;			/* 0x01c */
> +	u32 padding_3[3];				/* [0x020..0x028] */
> +	u32 rd_engine_en;				/* 0x02c */
> +	u32 rd_doorbell;				/* 0x030 */
> +	u32 padding_4;					/* 0x034 */
> +	u32 rd_ch_arb_weight_low;			/* 0x038 */
> +	u32 rd_ch_arb_weight_high;			/* 0x03c */
> +	u32 padding_5[3];				/* [0x040..0x048] */
> +	/* eDMA interrupts registers */
> +	u32 wr_int_status;				/* 0x04c */
> +	u32 padding_6;					/* 0x050 */
> +	u32 wr_int_mask;				/* 0x054 */
> +	u32 wr_int_clear;				/* 0x058 */
> +	u32 wr_err_status;				/* 0x05c */
> +	u32 wr_done_imwr_low;				/* 0x060 */
> +	u32 wr_done_imwr_high;				/* 0x064 */
> +	u32 wr_abort_imwr_low;				/* 0x068 */
> +	u32 wr_abort_imwr_high;				/* 0x06c */
> +	u32 wr_ch01_imwr_data;				/* 0x070 */
> +	u32 wr_ch23_imwr_data;				/* 0x074 */
> +	u32 wr_ch45_imwr_data;				/* 0x078 */
> +	u32 wr_ch67_imwr_data;				/* 0x07c */
> +	u32 padding_7[4];				/* [0x080..0x08c] */
> +	u32 wr_linked_list_err_en;			/* 0x090 */
> +	u32 padding_8[3];				/* [0x094..0x09c] */
> +	u32 rd_int_status;				/* 0x0a0 */
> +	u32 padding_9;					/* 0x0a4 */
> +	u32 rd_int_mask;				/* 0x0a8 */
> +	u32 rd_int_clear;				/* 0x0ac */
> +	u32 padding_10;					/* 0x0b0 */
> +	u32 rd_err_status_low;				/* 0x0b4 */
> +	u32 rd_err_status_high;				/* 0x0b8 */
> +	u32 padding_11[2];				/* [0x0bc..0x0c0] */
> +	u32 rd_linked_list_err_en;			/* 0x0c4 */
> +	u32 padding_12;					/* 0x0c8 */
> +	u32 rd_done_imwr_low;				/* 0x0cc */
> +	u32 rd_done_imwr_high;				/* 0x0d0 */
> +	u32 rd_abort_imwr_low;				/* 0x0d4 */
> +	u32 rd_abort_imwr_high;				/* 0x0d8 */
> +	u32 rd_ch01_imwr_data;				/* 0x0dc */
> +	u32 rd_ch23_imwr_data;				/* 0x0e0 */
> +	u32 rd_ch45_imwr_data;				/* 0x0e4 */
> +	u32 rd_ch67_imwr_data;				/* 0x0e8 */
> +	u32 padding_13[4];				/* [0x0ec..0x0f8] */
> +	/* eDMA channel context grouping */
> +	union Type {

Again no camecase please

-- 
~Vinod
