Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1C51B6097
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2020 18:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbgDWQUK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Apr 2020 12:20:10 -0400
Received: from mout.web.de ([212.227.15.3]:48529 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728865AbgDWQUJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 23 Apr 2020 12:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587658790;
        bh=RECRnytV1hNNzxqqBoYErlLWNw+ju+rqwbUUtNMzFEU=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=nsHzWqYCJ9JWmzLJg3xkN01dlC8XAS5g3jxsO4FGhXkfUZsBZAL5pmlpxBqGWlENn
         mYrR1w+G4zQVWIYaJSbYKUbbfpsRLp+4BcXo1Y2gzQKNBy95ptydlgYVi5+U+4qupH
         sN5l07pfPPNkQWNwdIO1rqQxHeh0Jvqc9qk1rgjw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.69.235]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MTPvz-1jbnjF1ael-00SKxc; Thu, 23
 Apr 2020 18:19:50 +0200
To:     Leonid Ravich <Leonid.Ravich@emc.com>, dmaengine@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, lravich@gmail.com,
        Alexander Barabash <Alexander.Barabash@dell.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v3 2/3] dmaengine: ioat: Remove unnecessary double
 completion timer modification
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b1bf65c7-23ac-2ab0-32ca-1887d134c90a@web.de>
Date:   Thu, 23 Apr 2020 18:19:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yiiEBurtdl+8orrOtD9SW73tJJNLlAzXYPv5uWWM17D/qOPC7fR
 GjDo0XMAlaDElh7w8HaYdJ4xErMp0XEZ+6EST2U6RdMnlidXaI64TnHzeXC8QpK5XP1JNxT
 1t6qGaeEHEr216PCLQckV/OmlzejyINnKDDLRyXvHTZ7M0G2uHVIu2cQsbRzHc1j1/IA4Cd
 5Le1NGevmLaGrTGzGtzbg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2rH1OeLb3Ok=:EawNNE9J0bovduALvc9Znx
 HzIHRDG0lkkOu73YYxajwtbwIXcNdMjJiMy6eBtVOeKMZGcEnhI00ji0tES1hfzWt2fDDbYq/
 iZ+FgZTcl5kgRSL6K5iceNQmjGsgFynMumb+KgtiiJP6WFjtBwPNhlRkQB+gCTxHfQ5q/n4CX
 1dHZJBzi1utkH+qP/gq4KRxB9zJg/+/8vIrmM6mjtlHNDsTdJE/knxWVnYj9eCw/dUQvFo94b
 hMoKeHuwMj8JN7coijmuiRdJjP0mI9wpERPkIkw9CbepxmzHD7CZ6RPCwL1hhETO09EW4o4kz
 +Fm6EoX33TuJl/fhyHANQdM4ww1U9lwUIkNZECGwZrG8pwidHlBkEWbaL/xZPb/iTUUq0wduE
 VyxgW2SRrBSr9AzMdYZw5LogB3UpxjBDgEnp7Q5Qh39Y0BjYf3BVJplKdGz4A35m/APmRHSGE
 szltekY1EhyccOR/EyecwVIfEaU0j02YJVceAwApYYIX54xlSuuWQ2HKYsRi0Aw/NK+7SFGhA
 mRZDYWS0w73JNgXtlsVGgwDn+e07NeEW/oXtXqDdfaSxkBLSrrI2QdqVBTjMEeUQ8cjC5UqtH
 E4YfEbnjMPlm+ftP16Ch+w56lLBwJ/UeSZfBa7dz0LU9kSRQyNnU7ER4bfXwUTIgBA4Z6r+Ww
 dqCg/1s7TypoPCfiKhDQGCHxoC8yBKhP3UyEzD3WdQyXpZOAJkRBcCfQm2i3KEMrD+tCNqLVe
 y7b5QucrvoiyX98AoipmkWTqnKAaVC0bm6+R2Pvmkv3CkVIXzQv2pRslE8lu5c/79qt8pbxbe
 07klnGbNRe4rgdAoR7Fxjio6DZTXk1Rjmqz0w79VQV1DvOEUeHvNdCJgSdBI+peZgMKZZdc0P
 BnqFEo79P4lQYpXKTXllK/XdiLGCEpy75Nk1t3IYYF/CPt/r6LAnmpT1TDkcpOlEUpIGBNrZa
 ABIy9o+ApAxlux6RtqX+f0p3iz3RUFk9vltYoR7epye7gvdTWpzDqnD56wLNPS3W/fE53JMoX
 JFLN5WU8QpOKX9IDiQaG9yiVDrAZa7i+HvVC86Mu9ahQSFb1HnSQASoKGpFMzhwV3R3YJZoTa
 TArI3n0PYfBKmwegR1rpGh5jUvtWxHc+MgPDsln7UHEXl+mhYjqwxYLDJ9BoI7x5skRxVFR/y
 bN/+6SLqUlxMSJsXwn9qBBh7ezXTRlv2FMWiAMvj6irI8R8oMkYUqpTiHzy0c1Fyviny4EZqT
 fI2FdyWco1M0AsGvS
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> removing unnecessary mod_timer from timeout handler
> incase of ioat_cleanup_preamble() is true  for cleaner code

I suggest to improve this change description.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3Dc578ddb39e565139897124e74e=
5a43e56538cb33#n151

* Please avoid typos in the patch subject and commit message.

* How do you think about to add the tag =E2=80=9CFixes=E2=80=9D because of=
 adjustments
  for the data synchronisation?

Regards,
Markus
