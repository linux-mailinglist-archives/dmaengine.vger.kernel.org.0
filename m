Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8795A2A2562
	for <lists+dmaengine@lfdr.de>; Mon,  2 Nov 2020 08:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgKBHij (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Nov 2020 02:38:39 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37190 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbgKBHih (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 Nov 2020 02:38:37 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201102073824euoutp0123acf48bbfbef19819e80f2867b8e5c4~DoM9caKp30782507825euoutp01T
        for <dmaengine@vger.kernel.org>; Mon,  2 Nov 2020 07:38:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201102073824euoutp0123acf48bbfbef19819e80f2867b8e5c4~DoM9caKp30782507825euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604302704;
        bh=GIQq/QJCa54rlYZanuAi3D4hvo+3okvDciIBojPdfD4=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=OtvQTRLBjPSSfIo/PxIiYiKTp08s3wsaXXmhQ/rMuYpOB9U0DTLiQE8youj7JQcmX
         OztICvh9VQ9Uim06JlKx4Lg8h94LMBpXX5sXfJ07blWSUMXJ/eq+59aPuojnhEBIlZ
         ry5XVKunsMRAregdgwNoIF7GqvxI1W++LZ4cuC80=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201102073815eucas1p23d08411e7f87fc499a836c27db83d43f~DoM1CeG302759527595eucas1p2T;
        Mon,  2 Nov 2020 07:38:15 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9B.19.06456.767BF9F5; Mon,  2
        Nov 2020 07:38:15 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201102073815eucas1p1a2c290cf20bbedf050e58749c7b77c88~DoM0rvard1861618616eucas1p1a;
        Mon,  2 Nov 2020 07:38:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201102073815eusmtrp1e9f7ac4ea8ef43df18f0bce170ca4468~DoM0rKftz0228502285eusmtrp1d;
        Mon,  2 Nov 2020 07:38:15 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-de-5f9fb76721cd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6D.89.06017.767BF9F5; Mon,  2
        Nov 2020 07:38:15 +0000 (GMT)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201102073814eusmtip2b8987146df564c7432a237a24fcdcd07~DoM0Ttamm2533625336eusmtip2v;
        Mon,  2 Nov 2020 07:38:14 +0000 (GMT)
Subject: Re: dmaengine: pl330 rare NULL pointer dereference in pl330_tasklet
To:     Krzysztof Kozlowski <krzk@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <a4bbe5e8-dd3d-d66f-a9fe-012bf7910943@samsung.com>
Date:   Mon, 2 Nov 2020 08:38:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201031190124.GA486187@kozik-lap>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djPc7rp2+fHG/x4oWGxeupfVovz5zew
        W1zeNYfNYsb5fUwWO++cYHZg9di0qpPN4/MmuQCmKC6blNSczLLUIn27BK6MM1cmMhasEa1o
        nCnewHhAsIuRk0NCwETibPsfpi5GLg4hgRWMEhOv7WGEcL4wSqxY8YAZwvnMKDHj93IWuJb9
        E6ASyxklWhedZwNJCAm8Z5S42RsEYgsL+Eh82DKbFaRIBGTumwcLwbrZBAwlut52gTXwCthJ
        LPq+ixHEZhFQkeifupcVxBYVSJL4+/kPM0SNoMTJmU/AejkFDCTurVjBBGIzC8hLbH87hxnC
        Fpe49WQ+2BMSAv/ZJK5e3MgGcaqLxNx/XawQtrDEq+Nb2CFsGYnTk3tYIBqaGSUenlvLDuH0
        MEpcbprBCFFlLXHn3C+gSRxAKzQl1u/SBzElBBwlbh6RhjD5JG68FYS4gU9i0rbpzBBhXomO
        NiGIGWoSs46vg9t68MIlZgjbQ+L2rUssExgVZyH5chaSz2Yh+WwWwgkLGFlWMYqnlhbnpqcW
        G+allusVJ+YWl+al6yXn525iBCaU0/+Of9rB+PVS0iFGAQ5GJR7eA8Lz44VYE8uKK3MPMUpw
        MCuJ8DqdPR0nxJuSWFmVWpQfX1Sak1p8iFGag0VJnNd40ctYIYH0xJLU7NTUgtQimCwTB6dU
        A6NkvFan4t3symvz7I6oMHtoMdbPyIhVibK0PyZ96JaGcaL2cqN7zQqaU7pyQvrZvGdoG3G9
        fD+1uIZl56lDLG+MpA9V3jsgmTPpWNAymbSZizjlOuK5fJN2bJAR2tRiHJ8aEBVrnhf+MXhL
        +dLdCYyGm3+t+zjdLvHp1s6fTk188011N0mtVmIpzkg01GIuKk4EAOUPPJUkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xe7rp2+fHG6xcyWexeupfVovz5zew
        W1zeNYfNYsb5fUwWO++cYHZg9di0qpPN4/MmuQCmKD2bovzSklSFjPziElulaEMLIz1DSws9
        IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MM1cmMhasEa1onCnewHhAsIuRk0NCwETi7P4J
        zF2MXBxCAksZJZb3vGKFSMhInJzWAGULS/y51sUGUfSWUeLxkS2MIAlhAR+JD1tmgxWJCKxg
        lNhzpAzEFhJoZpRYdVsNxGYTMJToegvSzMnBK2Ansej7LrBeFgEVif6pe8F6RQWSJF5emMoE
        USMocXLmExYQm1PAQOLeihVgcWYBM4l5mx8yQ9jyEtvfzoGyxSVuPZnPNIFRcBaS9llIWmYh
        aZmFpGUBI8sqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwEjZduznlh2MXe+CDzEKcDAq8fAe
        EJ4fL8SaWFZcmXuIUYKDWUmE1+ns6Tgh3pTEyqrUovz4otKc1OJDjKZAz01klhJNzgdGcV5J
        vKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBsbsnEk9QboFFraFnwo3
        unFqhLBb/xa2afzMlG4da7RYcMsEdZFpzmJrctaaN32afeNFP+err+2drF/+qv7ZERRfW7xC
        boOs6i77HXzPX6V7cU9l8F4WV6u+5ezzWfa3VD5abhZ447pwxza1ropX/BPkG6cu17gScD9u
        5dktTsI3xOU8N/1aNF+JpTgj0VCLuag4EQAAQcySqgIAAA==
X-CMS-MailID: 20201102073815eucas1p1a2c290cf20bbedf050e58749c7b77c88
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201031190133eucas1p2a90b3a7a1e39f4e778e288bb11a3ff9d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201031190133eucas1p2a90b3a7a1e39f4e778e288bb11a3ff9d
References: <CGME20201031190133eucas1p2a90b3a7a1e39f4e778e288bb11a3ff9d@eucas1p2.samsung.com>
        <20201031190124.GA486187@kozik-lap>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Krzysztof,

On 31.10.2020 20:01, Krzysztof Kozlowski wrote:
> I hit quite rare issue with pl330 DMA driver, difficult to reproduce
> (actually failed to do so):
>
> Happened during early reboot
>
> [  OK  ] Stopped target Graphical Interface.
> [  OK  ] Stopped target Multi-User System.
> [  OK  ] Stopped target RPC Port Mapper.
>           Stopping OpenSSH Daemonti[   75.447904] 8<--- cut here ---
> [   75.449506] Unable to handle kernel NULL pointer dereference at virtual address 0000000c
> ...
> [   75.690850] [<c0902f70>] (pl330_tasklet) from [<c034d460>] (tasklet_action_common+0x88/0x1f4)
> [   75.699340] [<c034d460>] (tasklet_action_common) from [<c03013f8>] (__do_softirq+0x108/0x428)
> [   75.707850] [<c03013f8>] (__do_softirq) from [<c034dadc>] (run_ksoftirqd+0x2c/0x4c)
> [   75.715486] [<c034dadc>] (run_ksoftirqd) from [<c036fbfc>] (smpboot_thread_fn+0x13c/0x24c)
> [   75.723693] [<c036fbfc>] (smpboot_thread_fn) from [<c036c18c>] (kthread+0x13c/0x16c)
> [   75.731390] [<c036c18c>] (kthread) from [<c03001a8>] (ret_from_fork+0x14/0x2c)
>
> Full log:
> https://protect2.fireeye.com/v1/url?k=7445a1ab-2bde98a7-74442ae4-000babff3563-a368d542db0c5500&q=1&e=62e4887b-e224-48e5-80a2-71163caeeec8&u=https%3A%2F%2Fkrzk.eu%2F%23%2Fbuilders%2F20%2Fbuilds%2F954%2Fsteps%2F22%2Flogs%2Fserial0
>
> 1. Arch ARM Linux
> 2. multi_v7_defconfig
> 3. Odroid HC1, ARMv7, octa-core (Cortex-A7+A15), Exynos5422 SoC
> 4. systemd, boot up with static IP set in kernel command line
> 5. No swap
> 6. Kernel, DTB and initramfs are downloaded with TFTP
> 7. NFS root (NFS client) mounted from a NFSv4 server
>
> Since I was not able to reproduce it, obviously I did not run bisect. If
> anyone has ideas, please share.

Well, I've also observed it a few times. IMHO it is related to the 
broken UART (in DMA mode) shutdown procedure. Usually it can be easily 
observed by flushing some random parts of the previously transmitted 
data to the UART console during the system shutdown. This also depends 
on the board and used system (especially the presence of systemd, which 
plays with UART differently than the old sysv init). IMHO there is a 
kind of use-after-free issue there, so the above pl330 stacktrace can be 
also observed depending on the timing and system load. This issue is 
there from the beginning of the DMA support. I have it on my todo list, 
but it had too low priority to take a look into it. I only briefly 
checked the related code a few years ago and noticed that the UART 
shutdown is not really synchronized with DMA. However that time I didn't 
find any simple fix, so I gave up.

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

