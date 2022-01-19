Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12AD4933F0
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jan 2022 05:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351488AbiASEH4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Jan 2022 23:07:56 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:41312 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351481AbiASEHh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Jan 2022 23:07:37 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20INx5iq012817;
        Wed, 19 Jan 2022 04:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=bGCfCt6vCAi9RXyrfJqfylamdOtbNoBkaaat0IE/Mnw=;
 b=lJnCGbChCBWiNCJ81/oD1H2AgQZqUQa5nCeYEKv3GgIDNnniyAqdpYR6Amtq5UVy85+S
 bSf1F6fc782Zb3Hp+C/dNgfwXSix7WwLstwfNiw/46TSej1TijDQQYxcpVwee5QgPbXs
 7qRvvqYwp1E1ZgJdwTidvqkrmMa2mDn9jRoaeO55cbOsT0QqUIBAR9kF8p5ggelQCa3G
 c12qT81DvBC9DrU2d50H1hksN5JKryq7e54/MdXUueGoXHOe0qsRXmf5/407TnolSx/k
 mH6KSOS3qms9+4ReTKr2kzH+nGTE/NnAmFSQ7vRhRr/fL6whaOCHGPK4AnnXhPGdKH9a 5A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc4q3wwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 04:06:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20J42AEu091613;
        Wed, 19 Jan 2022 04:06:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3dkqqpnr7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 04:06:18 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 20J46HPx110383;
        Wed, 19 Jan 2022 04:06:17 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3020.oracle.com with ESMTP id 3dkqqpnr68-1;
        Wed, 19 Jan 2022 04:06:17 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     sreekanth.reddy@broadcom.com, mchehab@kernel.org, mdf@kernel.org,
        mpe@ellerman.id.au, mporter@kernel.crashing.org, hch@infradead.org,
        bhelgaas@google.com, airlied@linux.ie,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        benh@kernel.crashing.org, ink@jurassic.park.msu.ru,
        davem@davemloft.net, akpm@linux-foundation.org, hao.wu@intel.com,
        vkoul@kernel.org, sathya.prakash@broadcom.com, paulus@samba.org,
        trix@redhat.com, arnd@arndb.de, yilun.xu@intel.com,
        suganath-prabu.subramani@broadcom.com, alex.bou9@gmail.com,
        awalls@md.metrocast.net, rth@twiddle.net, mattst88@gmail.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-alpha@vger.kernel.org, linux-fpga@vger.kernel.org,
        MPT-FusionLinux.pdl@broadcom.com, linux-media@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-scsi@vger.kernel.org, dmaengine@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 00/16] Remove usage of the deprecated "pci-dma-compat.h" API
Date:   Tue, 18 Jan 2022 23:06:09 -0500
Message-Id: <164256513502.31841.5177778968152773786.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kv-6XMqJc6gHKjMkAhgWOkvxgVt6FLHh
X-Proofpoint-ORIG-GUID: kv-6XMqJc6gHKjMkAhgWOkvxgVt6FLHh
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, 6 Jan 2022 22:45:13 +0100, Christophe JAILLET wrote:

> This serie axes all the remaining usages of the deprecated "pci-dma-compat.h"
> API.
> 
> All these patches have already been posted.
> 
> They have been generated with a coccinelle script.
> The tricky parts are patches that use dma_alloc_coherent() because the correct
> GFP flag has to be used in place of the previous embedded GFP_ATOMIC.
> 
> [...]

Applied to 5.17/scsi-queue, thanks!

[10/16] scsi: message: fusion: Remove usage of the deprecated "pci-dma-compat.h" API
        https://git.kernel.org/mkp/scsi/c/b114dda6f2f1
[11/16] scsi: mptbase: Use dma_alloc_coherent() in 'mpt_alloc_fw_memory()'
        https://git.kernel.org/mkp/scsi/c/2d50607260a6
[12/16] scsi: mptbase: Use dma_alloc_coherent()
        https://git.kernel.org/mkp/scsi/c/5c5e6b6f61e0
[13/16] scsi: mptsas: Use dma_alloc_coherent() in mptsas_exp_repmanufacture_info()
        https://git.kernel.org/mkp/scsi/c/7a960b3a5e37
[14/16] scsi: mptsas: Use dma_alloc_coherent()
        https://git.kernel.org/mkp/scsi/c/76a334d756c5
[15/16] scsi: mptctl: Use dma_alloc_coherent()
        https://git.kernel.org/mkp/scsi/c/706dc3b91989

-- 
Martin K. Petersen	Oracle Linux Engineering
