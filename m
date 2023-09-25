Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA3E7ADCB2
	for <lists+dmaengine@lfdr.de>; Mon, 25 Sep 2023 18:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjIYQHL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Sep 2023 12:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbjIYQHK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Sep 2023 12:07:10 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5E710A;
        Mon, 25 Sep 2023 09:07:03 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50308217223so10747095e87.3;
        Mon, 25 Sep 2023 09:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695658022; x=1696262822; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b61xHCzm/PcFjiQB0s4w1d7ci9lTYRpAnOY5ncVnfjQ=;
        b=eNP7hbLm4nobluVho5kIR6+qqKz/21MrDiLuFUtoH0E0XH9o2sgdBHOXBNwgblbI0O
         D4HKTD2Fzh8a90amRP4LU6d7XHalG78kNtZNyVhy+I3N29bVHAetFKIX7nIx34fglIXZ
         VdtHOb42FoTZAHmXrdrZ6ePdQZofHdO2yC9jgw/RQMc5GkCmYE3YtSpKqPRazr1v7/aY
         5kmi5/aJs5ygpuwwcFccGW7b7i8mnHOAiQFTf7Pjxpf3g88dATvdomsVgdKl8o5nZU4v
         mV9rLabwTST6aPI8Ct2b9IaQ9g0vw5GcHfKbxlzvdRynPmsH0HjSKjr2MtE4dFir6Od2
         zDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695658022; x=1696262822;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b61xHCzm/PcFjiQB0s4w1d7ci9lTYRpAnOY5ncVnfjQ=;
        b=imO07eDlNMFt11kGcDBE0QSDk4KQnAg27e+xD+V9qTAJ1XnAANwNGFgj2GSvLZZDtS
         3HSVl7WC7deTpk1wcoXMnbXV4D6AyT3lOKkRHPbhJu60e0/0Sc4y7YX8QDPTlol3DA+k
         hSikSboonHuEQuEZtaWZRT9PCkyQe8RULUguf4B9zUhEMS4UfU/4pJJ6X/8qRIuIn+Zz
         87MG/QJaYB5CNR3UPKHLcI2NRII6zS+6b/XGoVujIfXNGZZe4JyjsdQSqz4XGGNeVCki
         d8ciOK0JR3pADoIx6qZHsVHpgfpJymXQUwU4Dr0cyYgevHJNdlmW4elvJ1v/J/DU5CJW
         BloQ==
X-Gm-Message-State: AOJu0YzqSxlV2yzFQvrnVHT6PYhq0eiLZJseNAqz5bz2YfW+KvniGZsG
        0us7oqqtuzClgcRsXYGoEd4=
X-Google-Smtp-Source: AGHT+IHJJGG4Om+E1MDWFHJE3JaAFJNt/rkVuW2TQWaswK1DcEB3uaaKTAWvKbQlJnolszT/sx3//g==
X-Received: by 2002:a05:6512:2248:b0:503:2deb:bbc1 with SMTP id i8-20020a056512224800b005032debbbc1mr7585940lfu.22.1695658021148;
        Mon, 25 Sep 2023 09:07:01 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id l11-20020ac2554b000000b00502fe164ce6sm1883245lfk.204.2023.09.25.09.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 09:07:00 -0700 (PDT)
Date:   Mon, 25 Sep 2023 19:06:56 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH 4/9] dmaengine: dw-edma: HDMA: Add memory barrier before
 starting the DMA transfer in remote setup
Message-ID: <3kqkdegy56hr7ghwrg42h3rjc3hcpgfz4jkqdhri2j2qjg3crx@cpuy2ehukzdp>
References: <20230619170201.5hbgte2optjlbx55@mobilestation.baikal.int>
 <20230619203207.694bfac6@kmaincent-XPS-13-7390>
 <tpowhctppelni47dosc27cg4vmzwdqnuvf3rukvmju2guoxzsr@wgxomqzfv6ch>
 <20230620153006.036ca3ba@kmaincent-XPS-13-7390>
 <qwkwtsjmfkmvsx4pmjetoxkjrpuwkndm6h6ntkpehxutz2h2jm@bmdzt7ywiuvs>
 <20230621151948.36125997@kmaincent-XPS-13-7390>
 <ti6avu3xdrw7rjwskmemuxu4tcerfq3wd3y4c4v26pbjqjcs5h@izqmikcjsv56>
 <20230622171203.6857b918@kmaincent-XPS-13-7390>
 <phrpjn5dtqfo2fwjlkrsepjl4mgmjc24skpvcjo43g3p5sjv3g@mfzvfz7ygdad>
 <20230912105152.42cf1454@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230912105152.42cf1454@kmaincent-XPS-13-7390>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Köry

On Tue, Sep 12, 2023 at 10:52:10AM +0200, Köry Maincent wrote:
> Hello Serge,
> 
> I am back with an hardware design answer:
> > "Even though the PCIe itself respects the transactions ordering, the 
> > AXI bus does not have an end-to-end completion acknowledgement (it
> > terminates at the PCIe EP boundary with bus), and does not guaranteed
> > ordering if accessing different destinations on the Bus. So, an access to LL
> > could be declared complete even though the transactions is still being
> > pipelined in the AXI Bus. (a dozen or so clocks, I can give an accurate
> > number if needed)
> > 
> > The access to DMA registers is done through BAR0 “rolling”
> > so the transaction does not actually go out on the AXI bus and
> > looped-back to PCIe DMA, rather it stays inside the PCIe EP.
> > 
> > For the above reasons, hypothetically, there’s a chance that even if the DMA
> > LL is accessed before the DM DB from PCIe RC side, the DB could be updated
> > before the LL in local memory."

Thanks for the detailed explanation. It doesn't firmly point out to
the root cause of the problem but mainly confirms a possible race
condition inside the remote PCIe device itself. That's what I meant in
my suggestion 3.

> 
> On Thu, 22 Jun 2023 19:22:20 +0300
> Serge Semin <fancer.lancer@gmail.com> wrote:
>  
> > If we get assured that hardware with such problem exists (if you'll get
> > confirmation about the supposition 3. above) then we'll need to
> > activate your trick for that hardware only. Adding dummy reads for all
> > the remote eDMA setups doesn't look correct since it adds additional
> > delay to the execution path and especially seeing nobody has noticed
> > and reported such problem so far (for instance Gustavo didn't see the
> > problem on his device otherwise he would have fixed it).
> > 
> > So if assumption 3. is correct then I'd suggest the next
> > implementation: add a new dw_edma_chip_flags flag defined (a.k.a
> > DW_EDMA_SLOW_MEM), have it specified via the dw_edma_chip.flags field
> > in the Akida device probe() method and activate your trick only if
> > that flag is set.
> 

> The flag you suggested is about slow memory write but as said above the issue
> comes from the AXI bus and not the memory. 

AXI bus is a bus what is utilized to access the LL-memory in your
case. From the CPU perspective it's the same since the access time
depends on the both parts performance.

> I am wondering why you don't see
> this issue. 

Well, in my case the DW PCIe eDMA controller is _locally_ implemented.
So it' CSRs and the LL-memory are accessible from the CPU side over a
system interconnect. The LL-memory is allocated from the system RAM
(CPU<->_AXI IC_<->AXI<->DDR<->RAM), while the DW PCIe CSRs are just
the memory-mapped IO space (CPU<->_AXI IC_<->APB<->AXI<->DBI<->CDM).
So in my case:
1. APB is too slow to be updated before the Linked-List data.
2. MMIO accessors (writel()/readl()/etc) are defined in a way so all
the memory updates (normal memory writes and reads) are supposed to be
completed before any further MMIO accesses.

So the ordering is mainly assured by 2 in case of the local DW PCIe
eDMA implementation.

Your configuration is different. You have the DW PCIe eDMA controller
implemented remotely. In that case you have both CSRs and Linked-list
memory accessible over a chain like:
CPU<->_Some IC_<->AXI/Native<->Some PCIe Host<->... PCIe bus ... <-+
                                                                   |
+------------------------------------------------------------------+
|
+->DW eDMA
   +> BARx<->CDM CSRs
   +> BARy<->AHB/AXI/APB/etc<->Some SRAM
                    ^
                    |
                    +-----------------------+
                                            |
AFAICS a race condition happens due to this + bus being too slow. So
in case if the LL and CSRs IO writes are performed right one after
another with no additional delays or syncs in between them, then
indeed the later one can be finished earlier than the former one.

> If I understand well it should be present on all IP as the DMA
> register is internal to the IP and the LL memory is external through AXI bus.
> Did you stress your IP? On my side it appears with lots of operation using
> several (at least 3) thread through 2 DMA channels.

I didn't stress it up with such test. But AFAICS from a normal systems
implementations the problem isn't relevant for the locally accessible
DW PCIe eDMA controllers otherwise at the very least it would have
popped up in many other places in kernel.

What I meant in my previous message was that it was strange Gustavo
(the original driver developer) didn't spot the problem you were
referring to. He was the only one having the Remote DW eDMA hardware
at hands to perform such tests. Anyway seeing we've got to some
understanding around the problem and since based on the DW PCIe RP/EP
internals the CSRs and Application memory are indeed normally accessed
over the different buses, let's fix the problem as you suggest with
just using the DW_EDMA_CHIP_LOCAL flag. But please:
1. Fix it for both HDMA and EDMA controllers.
2. Create functions like dw_edma_v0_sync_ll_data() and
dw_hdma_v0_sync_ll_data() between the dw_Xdma_v0_core_write_chunk()
and dw_Xdma_v0_core_start() methods, which would perform the
dummy-read from the passed LL-chunk in order to sync the remote memory
writes.
3. Based on all our discussions add a saner comment to these methods
about why the dummy-read is needed for the remote DW eDMA setups.

-Serge(y)

> 
> Köry
