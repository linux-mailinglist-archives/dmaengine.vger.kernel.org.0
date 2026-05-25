Return-Path: <dmaengine+bounces-10881-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DmiML53FGokNgcAu9opvQ
	(envelope-from <dmaengine+bounces-10881-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 18:24:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D60C5CCD3A
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 18:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1567D3003BD8
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 16:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D958282F3E;
	Mon, 25 May 2026 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VdZk1QbN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854503F54C7
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779726256; cv=none; b=i+i6eesFNvMlrtGVUtekG20WQpVf5/c42tzhCvkprp0Lnmdwdvn0oCepghZa30w9xfD3YllByKmOsxyy3diJP6Fqc4iQZkt+t2Q0dMJJF68ACaCzeiATM7x4TggBTjeTNf0j4SMHeyZbDbrbwF7Ycs9ZadoLCk946WdZi0vwPuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779726256; c=relaxed/simple;
	bh=Ix5V9VVReiSoQo6AB3QETxLfhu0cCyAdGQjvJGHnDxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=srFebzD2cwf2OBp3GUVoit8qp9rud/IXAsMjuE9K8t0lG889C8yvLRUkcJC8GluRlNsAYUVrzODFP5sjT01++GrjmPT0FpPflfUTBgONTf6a5U1Gvf7wwxgkrJD6kILkqz0zhhuC+SydpOOg2ig+Zyw9VD/qokQM+l5o4RqlSfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VdZk1QbN; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-452169ae568so6258577f8f.3
        for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 09:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779726251; x=1780331051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WThGrJlj0+d9TTzzXLAp8aZigkvM5HszOOE/MfwSIgg=;
        b=VdZk1QbNytpFbuiKsbE3wW+kpdUiwO8Oy0pgmIL3aXlcs3cEHrAyW3jehgTlLTi83n
         wNh17lNTxLLkgF2MNP6aUmiJt0rCd+jWtZnbWylWlzXlbassqIWZOQCLLOffSEkhSbua
         +xQlxnJ9qX8lxTNaTtv21kd2cKIugw5nnDeVK3GmUj9N/fqumL9jVllnCfVPprFZDh/q
         LoGx1NaFUjwhYiOVtB2Bo+Ks5HuJmMsqFtXlcMGYkbS3CeNG7DthkcDMBrct+OJR510y
         SClO2VskO/kDqNdoapbvTguZijtUGevTSuelHBqTta1LS7zaFq3R8yRear0hL0uSsY1S
         vaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779726251; x=1780331051;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WThGrJlj0+d9TTzzXLAp8aZigkvM5HszOOE/MfwSIgg=;
        b=UGk+6TvfPVPIjpi5Z1fp9jGCM0t7m+EoyxGg9PVvzHnU5I6tRW9vglBOaJn632JuBg
         oRpysfdX9N+bzmXvNE1g2tYjkvusgjFCb6yO0sEXjJKcQAI1Q2Q1rvQHHTjsfuVweTeI
         T2gtvqVdIXccKMH4X5JRV1eol8HgOcEK9LmbDD0CO9zsgvbeZXJLLHKFxtfdOU3aorVy
         vpVbxZTqS0+NRhszqeZt9m79fijXQvlCRXPpNOiLIteVyshClFkhzx4s+aqiwARpUXq6
         UtuEuJjLOwt0cXID35OZSqYs0iigd+Gn68/t+7wwgrArHTSsUeg8gtDrQQqPfz0lo3Gp
         SisQ==
X-Forwarded-Encrypted: i=1; AFNElJ8XJJWSt+llUQsbifcR2llOqcNTB835UD1Gqq7ddikc1jjUPtLSnbHkquFT9hBbR1X8f9FGBxOnUZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCHLXhWu0BydkF77/2Fb58YCedYnk78aNTl9Qr6ciCE/9V7CuA
	JKebQZDCM6CsQVIIw1yYnsOlnI7k65BXGIvSFDMqQIq1KIFlLb0U4AUmrHGU90OLHc4=
X-Gm-Gg: Acq92OGDx4pTZEB8yPVzN1flVwuTu0Red5LFsWkRv/ua1lOgQBlR0gg+SrYV97zz9pj
	7jgi8JuWz0k5cRsqd859p0Z0kxMVQL6Pyhd98BlGWEOOF3s+Ojywm0MxRi8dRHX947H3j5RDNIL
	oyhDP53G62HkuRbVgrcu95nbDFxjqhLLgPdz0QKY5toYuymnpBhcjKF14qApShkZvF+jYH7uk3j
	IXwjR+tKoB1B/sBVhuzpaeEeL7ROwMmnm90O2Q39gJc4XOAMDJXicmqi4zVslC7zpvBKr6o6ThX
	dzDRsReUHrUQSqmXPhSx02Y5TPIKgcF8FJKYT3JFpKJiY++cBwuHukOTJo5DG9ScQbKFHG1oy1j
	2weJoCC0DniyQs6POqYttbdZ6mg8f8enQNb69j94Ql9m1pdPIyVqf8tpUrhw+7yh/EjP6L/U1qC
	+1Wp1pY8wn4OHN3x2K4RjkE9n6bG4ACOIumLbErP4r4dL6obY9HsAs702Ny6KIx3L7h9KQ3CCO5
	hCmkuqwNfq6K2FYhKzCWZeTFI07UYaCsLArDA+eSbM9IzaqFyYMkdj+i0cWUJXLzZ4+aA==
X-Received: by 2002:a05:6000:26cf:b0:45e:b215:12e9 with SMTP id ffacd0b85a97d-45eb368903emr24724531f8f.6.1779726250728;
        Mon, 25 May 2026 09:24:10 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d47b82sm28202483f8f.19.2026.05.25.09.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 09:24:10 -0700 (PDT)
Message-ID: <4e54ae4a-4f7b-451d-9b37-97f30b8fefba@suse.com>
Date: Mon, 25 May 2026 18:24:07 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] moduleparam: Route DEFINE_KERNEL_PARAM_OPS get
 pointer via _Generic
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Pengpeng Hou
 <pengpeng@iscas.ac.cn>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Corey Minyard <corey@minyard.net>, Gabriel Somlo <somlo@cmu.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Hannes Reinecke <hare@suse.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
 Tiwei Bie <tiwei.btw@antgroup.com>, Benjamin Berg <benjamin.berg@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "David E. Box" <david.e.box@linux.intel.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, John Johansen <john.johansen@canonical.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-um@lists.infradead.org,
 linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 qemu-devel@nongnu.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
 linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260521133315.work.845-kees@kernel.org>
 <20260521133326.2465264-7-kees@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260521133326.2465264-7-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iscas.ac.cn,nod.at,cambridgegreys.com,sipsolutions.net,minyard.net,cmu.edu,redhat.com,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,acm.org,ziepe.ca,ideasonboard.com,google.com,suse.de,HansenPartnership.com,oracle.com,arm.com,linuxfoundation.org,rowland.harvard.edu,linux.alibaba.com,akamai.com,antgroup.com,orcam.me.uk,infradead.org,linux.ibm.com,alien8.de,zytor.com,atomlin.com,linux-foundation.org,canonical.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,googlegroups.com,kvack.org,lists.ubuntu.com,lists.infradead.org,lists.sourceforge.net,nongnu.org,lists.freedesktop.org,lists.ozlabs.org,lists.one-eyed-alien.net,lists.linux.dev];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-10881-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petr.pavlu@suse.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[98];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,suse.com:email,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: 1D60C5CCD3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/21/26 3:33 PM, Kees Cook wrote:
> Make the DEFINE_KERNEL_PARAM_OPS family route their _get argument to
> either .get (struct seq_buf *) or .get_str (char *) at compile time
> based on the pointer's actual function signature. Two helper macros
> do the routing:
> 
>   _KERNEL_PARAM_OPS_GET     - return the pointer if it has the seq_buf
>                               signature, otherwise NULL of that type
>   _KERNEL_PARAM_OPS_GET_STR - mirror image for the char * signature
> 
> Both use _Generic; only the two valid function-pointer types are
> listed, so any third-party type is a compile error rather than
> silently falling through.
> 
> Now a callback whose body has been migrated from char * to struct
> seq_buf * needs no change at its kernel_param_ops initialization site,
> because the macro picks up the new type automatically and assigns to
> the correct field.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  include/linux/moduleparam.h | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
> index c52120f6ac28..795bc7c654ef 100644
> --- a/include/linux/moduleparam.h
> +++ b/include/linux/moduleparam.h
> @@ -85,15 +85,32 @@ struct kernel_param_ops {
>   *
>   *   static DEFINE_KERNEL_PARAM_OPS(my_ops, my_set, my_get);
>   *
> - * Routing the @_set and @_get function pointers through the macro
> - * (rather than naming the struct fields at every call site) lets the
> - * field layout change in one place when callbacks are migrated to a
> - * new signature.
> + * @_get may be either of:
> + *   int (*)(struct seq_buf *, const struct kernel_param *) (seq_buf)
> + *   int (*)(char *, const struct kernel_param *)           (legacy)
> + *
> + * The macro uses _Generic to route the function pointer to the
> + * matching field (.get or .get_str) at compile time, leaving the
> + * other field NULL. Each helper matches the wrong prototype signature
> + * and returns NULL, falling through to the default branch otherwise;
> + * if @_get has neither expected signature the assignment to the
> + * fields gets a normal compile-time type-mismatch error.
>   */
> +#define _KERNEL_PARAM_OPS_GET(_get)					\
> +	_Generic((_get),						\
> +	    int (*)(char *, const struct kernel_param *): NULL,		\
> +	    default: (_get))
> +
> +#define _KERNEL_PARAM_OPS_GET_STR(_get)					\
> +	_Generic((_get),						\
> +	    int (*)(struct seq_buf *, const struct kernel_param *): NULL, \
> +	    default: (_get))
> +
>  #define DEFINE_KERNEL_PARAM_OPS(_name, _set, _get)			\
>  	const struct kernel_param_ops _name = {				\
>  		.set = (_set),						\
> -		.get_str = (_get),					\
> +		.get = _KERNEL_PARAM_OPS_GET(_get),			\
> +		.get_str = _KERNEL_PARAM_OPS_GET_STR(_get),		\
>  	}
>  
>  /* As DEFINE_KERNEL_PARAM_OPS, with KERNEL_PARAM_OPS_FL_NOARG set. */
> @@ -101,14 +118,16 @@ struct kernel_param_ops {
>  	const struct kernel_param_ops _name = {				\
>  		.flags = KERNEL_PARAM_OPS_FL_NOARG,			\
>  		.set = (_set),						\
> -		.get_str = (_get),					\
> +		.get = _KERNEL_PARAM_OPS_GET(_get),			\
> +		.get_str = _KERNEL_PARAM_OPS_GET_STR(_get),		\
>  	}
>  
>  /* As DEFINE_KERNEL_PARAM_OPS, with an additional .free callback. */
>  #define DEFINE_KERNEL_PARAM_OPS_FREE(_name, _set, _get, _free)		\
>  	const struct kernel_param_ops _name = {				\
>  		.set = (_set),						\
> -		.get_str = (_get),					\
> +		.get = _KERNEL_PARAM_OPS_GET(_get),			\
> +		.get_str = _KERNEL_PARAM_OPS_GET_STR(_get),		\
>  		.free = (_free),					\
>  	}
>  

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- Petr

